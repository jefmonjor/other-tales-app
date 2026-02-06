import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../theme/app_spacing.dart';
import '../../presentation/widgets/other_tales_spinner.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: isEnabled ? AppGradients.brand : null,
        color: isEnabled ? null : AppColors.primary.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: isEnabled
            ? const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 5),
                  blurRadius: 15,
                )
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: isEnabled ? onPressed : null,
          child: Center(
            child: isLoading
                ? const OtherTalesSpinner(size: 24, color: Colors.white)
                : Text(label, style: AppTypography.button),
          ),
        ),
      ),
    );
  }
}
