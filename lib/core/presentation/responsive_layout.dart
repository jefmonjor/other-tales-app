import 'package:flutter/material.dart';

/// Placeholder widget for future responsive behavior (e.g., adaptive layouts
/// based on screen size or platform). Currently acts as a passthrough that
/// renders its child unchanged. Retained because app.dart depends on it.
class ResponsiveLayout extends StatelessWidget {
  final Widget child;

  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
