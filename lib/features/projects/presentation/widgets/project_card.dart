import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String? synopsis;
  final String? coverUrl;
  final String? genre; // New field
  final int currentWordCount; // New field
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.title,
    this.synopsis,
    this.coverUrl,
    this.genre,
    this.currentWordCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Cover
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceInput,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(2, 6),
                    blurRadius: 7,
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                   // Image Placeholder or Actual Image
                   Positioned.fill(
                    child: _buildCoverImage(),
                   ),
                   
                   // Gradient Overlay for text readability if needed, or style
                   Positioned.fill(
                     child: Container(
                       decoration: const BoxDecoration(
                         gradient: LinearGradient(
                           begin: Alignment.topCenter,
                           end: Alignment.bottomCenter,
                           colors: [Colors.transparent, Colors.black26],
                         )
                       ),
                     ),
                   ),

                   // Spine Effect (Left Edge Gradient)
                   Positioned(
                     left: 0,
                     top: 0,
                     bottom: 0,
                     width: 12,
                     child: Container(
                       decoration: BoxDecoration(
                         gradient: LinearGradient(
                           colors: [
                             Colors.black.withOpacity(0.3),
                             Colors.transparent,
                             Colors.black.withOpacity(0.1),
                           ],
                           begin: Alignment.centerLeft,
                           end: Alignment.centerRight,
                         )
                       ),
                     ),
                   ),

                   // Genre Badge
                   if (genre != null)
                     Positioned(
                       top: 8,
                       right: 8,
                       child: Container(
                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                         decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.9),
                           borderRadius: BorderRadius.circular(12),
                           boxShadow: const [
                             BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                           ]
                         ),
                         child: Text(
                           genre!.toUpperCase(),
                           style: AppTypography.caption.copyWith(
                             fontSize: 10,
                             fontWeight: FontWeight.bold,
                             color: AppColors.textPrimary,
                           ),
                         ),
                       ),
                     ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppSpacing.s),
          
          // Title
          Text(
            title,
            style: AppTypography.h2.copyWith(fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          
          // Synopsis or Word Count
          const SizedBox(height: 4),
          if (synopsis != null && synopsis!.isNotEmpty)
            Text(
              synopsis!,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          else
             Text(
              '$currentWordCount words',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCoverImage() {
    // Basic valid URL check or use generic placeholder
    if (coverUrl != null && coverUrl!.startsWith('http')) {
      return Image.network(
        coverUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Icon(Icons.book, color: Colors.grey[400], size: 40),
    );
  }
}
