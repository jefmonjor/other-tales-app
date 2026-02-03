import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class GradientBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GradientBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Floating margins
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.m, 
      ), 
      height: 70, // Slightly compact for floating look
      decoration: BoxDecoration(
        gradient: AppGradients.brand,
        borderRadius: BorderRadius.circular(35), // Fully rounded ends
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.folder_open_outlined, Icons.folder),
          _buildNavItem(1, Icons.check_circle_outline, Icons.check_circle),
          _buildNavItem(2, Icons.home_outlined, Icons.home, isLarge: true),
          _buildNavItem(3, Icons.settings_outlined, Icons.settings),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, {bool isLarge = false}) {
    final isSelected = currentIndex == index;
    return IconButton(
      onPressed: () => onTap(index),
      icon: Icon(
        isSelected ? activeIcon : icon,
        color: Colors.white.withOpacity(isSelected ? 1.0 : 0.7),
        size: isLarge ? 32 : 24,
      ),
    );
  }
}
