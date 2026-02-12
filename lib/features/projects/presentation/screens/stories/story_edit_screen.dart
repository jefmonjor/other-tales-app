import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../core/services/image_picker_service.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../auth/presentation/widgets/gradient_app_bar.dart';
import '../../providers/stories_provider.dart';

class StoryEditScreen extends ConsumerStatefulWidget {
  final String projectId;
  final String? storyId;

  const StoryEditScreen({
    super.key,
    required this.projectId,
    this.storyId,
  });

  @override
  ConsumerState<StoryEditScreen> createState() => _StoryEditScreenState();
}

class _StoryEditScreenState extends ConsumerState<StoryEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _themeController = TextEditingController();
  final _secondaryPlotsController = TextEditingController();
  String? _currentImageUrl;
  File? _pickedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.storyId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final stories = await ref.read(storiesProvider(widget.projectId).future);
        final story = stories.firstWhere((s) => s.id == widget.storyId);
        _titleController.text = story.title;
        _synopsisController.text = story.synopsis ?? '';
        _themeController.text = story.theme ?? '';
        _secondaryPlotsController.text = story.secondaryPlots ?? '';
        setState(() {
          _currentImageUrl = story.imageUrl;
        });
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _synopsisController.dispose();
    _themeController.dispose();
    _secondaryPlotsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final file = await ImagePickerService().pickImage();
      if (file != null) {
        setState(() => _pickedImage = file);
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.genericError}: $e')),
        );
      }
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final data = {
        'title': _titleController.text,
        'synopsis': _synopsisController.text,
        'theme': _themeController.text,
        'secondaryPlots': _secondaryPlotsController.text,
        // Send imageUrl only if we are keeping the old one
        if (_currentImageUrl != null && _pickedImage == null) 'imageUrl': _currentImageUrl,
      };

      if (widget.storyId != null) {
        await ref.read(storiesProvider(widget.projectId).notifier).updateStory(widget.storyId!, data, _pickedImage);
      } else {
        await ref.read(storiesProvider(widget.projectId).notifier).create(data, _pickedImage);
      }
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.genericError}: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: GradientAppBar(
        title: widget.storyId != null ? l10n.editStory : l10n.createStory,
        showBackButton: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        image: _pickedImage != null
                            ? DecorationImage(
                                image: FileImage(_pickedImage!),
                                fit: BoxFit.cover,
                              )
                            : _currentImageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(_currentImageUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                      ),
                      child: (_pickedImage == null && _currentImageUrl == null)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                                Text(l10n.tapToAddCover, style: const TextStyle(color: Colors.grey)),
                              ],
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),

                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: l10n.storyTitleLabel, border: const OutlineInputBorder()),
                    validator: (value) => value == null || value.isEmpty ? l10n.storyTitleRequired : null,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  TextFormField(
                    controller: _synopsisController,
                    decoration: InputDecoration(labelText: l10n.storySynopsisLabel, border: const OutlineInputBorder()),
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  TextFormField(
                    controller: _themeController,
                    decoration: InputDecoration(labelText: l10n.storyThemeLabel, border: const OutlineInputBorder()),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  TextFormField(
                    controller: _secondaryPlotsController,
                    decoration: InputDecoration(labelText: l10n.storySecondaryPlotsLabel, border: const OutlineInputBorder()),
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.l),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _save,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(l10n.save),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
             Container(
               color: Colors.black.withValues(alpha: 0.3),
               child: Center(
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     const CircularProgressIndicator(),
                     const SizedBox(height: 16),
                     Text(l10n.uploadingImage, style: const TextStyle(color: Colors.white)),
                   ],
                 ),
               ),
             ),
        ],
      ),
    );
  }
}
