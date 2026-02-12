import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../auth/presentation/widgets/gradient_app_bar.dart';
import '../../providers/ideas_provider.dart';

class IdeaEditScreen extends ConsumerStatefulWidget {
  final String projectId;
  final String? ideaId;

  const IdeaEditScreen({
    super.key,
    required this.projectId,
    this.ideaId,
  });

  @override
  ConsumerState<IdeaEditScreen> createState() => _IdeaEditScreenState();
}

class _IdeaEditScreenState extends ConsumerState<IdeaEditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.ideaId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final ideas = await ref.read(ideasProvider(widget.projectId).future);
        final idea = ideas.firstWhere((i) => i.id == widget.ideaId);
        _titleController.text = idea.title;
        _contentController.text = idea.content ?? '';
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (_titleController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.ideaTitleRequired)),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final data = {
        'title': _titleController.text,
        'content': _contentController.text,
      };

      if (widget.ideaId != null) {
        await ref.read(ideasProvider(widget.projectId).notifier).updateIdea(widget.ideaId!, data);
      } else {
        await ref.read(ideasProvider(widget.projectId).notifier).create(data);
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
        title: widget.ideaId != null ? l10n.editIdea : l10n.createIdea,
        showBackButton: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  style: AppTypography.h3,
                  decoration: InputDecoration(
                    hintText: l10n.ideaTitleHint,
                    border: InputBorder.none,
                  ),
                ),
                const Divider(),
                Expanded(
                  child: TextField(
                    controller: _contentController,
                    style: AppTypography.bodyRegular,
                    maxLines: null, // Expands
                    expands: true,
                    decoration: InputDecoration(
                      hintText: l10n.ideaContentHint,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _save,
                    child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(l10n.saveIdea),
                  ),
                ),
              ],
            ),
          ),
           if (_isLoading)
             Container(
               color: Colors.black.withValues(alpha: 0.3),
               child: const Center(child: CircularProgressIndicator()),
             ),
        ],
      ),
    );
  }
}
