import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Assuming spinkit is used, or native
import '../../theme/app_colors.dart';

class OtherTalesSpinner extends StatelessWidget {
  final double size;
  final Color? color;

  const OtherTalesSpinner({
    super.key,
    this.size = 50.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Elegant, simple spinner matching the app's aesthetic
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}
