import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../core/services/image_picker_service.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../auth/presentation/widgets/gradient_app_bar.dart';
import '../../providers/characters_provider.dart';

class CharacterEditScreen extends ConsumerStatefulWidget {
  final String projectId;
  final String? characterId;

  const CharacterEditScreen({
    super.key,
    required this.projectId,
    this.characterId,
  });

  @override
  ConsumerState<CharacterEditScreen> createState() => _CharacterEditScreenState();
}

class _CharacterEditScreenState extends ConsumerState<CharacterEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _physicalDescriptionController = TextEditingController();
  String? _currentImageUrl;
  File? _pickedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.characterId != null) {
      // Load existing data
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final characters = await ref.read(charactersProvider(widget.projectId).future);
        final character = characters.firstWhere((c) => c.id == widget.characterId);
        _nameController.text = character.name;
        _roleController.text = character.role ?? '';
        _descriptionController.text = character.description ?? '';
        _physicalDescriptionController.text = character.physicalDescription ?? '';
        setState(() {
          _currentImageUrl = character.imageUrl;
        });
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _descriptionController.dispose();
    _physicalDescriptionController.dispose();
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
        'name': _nameController.text,
        'role': _roleController.text,
        'description': _descriptionController.text,
        'physicalDescription': _physicalDescriptionController.text,
        // Send imageUrl only if we are keeping the old one and haven't picked a new one
        if (_currentImageUrl != null && _pickedImage == null) 'imageUrl': _currentImageUrl,
      };

      if (widget.characterId != null) {
        await ref.read(charactersProvider(widget.projectId).notifier).updateCharacter(widget.characterId!, data, _pickedImage);
      } else {
        await ref.read(charactersProvider(widget.projectId).notifier).create(data, _pickedImage);
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
        title: widget.characterId != null ? l10n.editCharacter : l10n.createCharacter,
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
                   // Image Upload Widget
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
                                Text(l10n.tapToAddPhoto, style: const TextStyle(color: Colors.grey)),
                              ],
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),

                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: l10n.characterNameLabel, border: const OutlineInputBorder()),
                    validator: (value) => value == null || value.isEmpty ? l10n.characterNameRequired : null,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  TextFormField(
                    controller: _roleController,
                    decoration: InputDecoration(labelText: l10n.characterRoleLabel, border: const OutlineInputBorder()),
                  ),
                  const SizedBox(height: AppSpacing.m),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: l10n.characterDescriptionLabel, border: const OutlineInputBorder()),
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.m),
                  TextFormField(
                    controller: _physicalDescriptionController,
                    decoration: InputDecoration(labelText: l10n.characterPhysicalDescriptionLabel, border: const OutlineInputBorder()),
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
