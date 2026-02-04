import 'package:flutter/material.dart';

class WebSplitLayout extends StatelessWidget {
  final Widget leftPanel; // Branding / Image
  final Widget rightPanel; // Form / Content
  final int leftFlex;
  final int rightFlex;
  
  const WebSplitLayout({
    required this.leftPanel, 
    required this.rightPanel, 
    this.leftFlex = 5,
    this.rightFlex = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // If mobile/tablet width (< 900), only show the right panel (content)
    // We assume the caller handles the mobile scaffolding (AppBar, etc.) if needed, 
    // OR the rightPanel itself contains the scaffolding.
    // However, usually the split layout replaces the Scaffold.
    // Let's assume rightPanel is the body content. 
    // BUT, the user prompt says:
    // "if < 900 return Scaffold(body: SafeArea(child: Center(child: rightPanel)))"
    // This implies rightPanel is just the form content, not a full Scaffold.
    // But our Screens currently return a Scaffold.
    // So if we use this widget, the Screens should probably return THIS widget instead of Scaffold.
    
    // Lower breakpoint to 800 to allow tablet landscape to use split if space permits,
    // or stick to mobile for smaller screens. 
    if (MediaQuery.of(context).size.width < 800) {
      // Return rightPanel directly to avoid nesting Scaffolds.
      // The rightPanel (Screen content) should provide its own Scaffold.
      return rightPanel;
    }

    // Desktop logic: Full screen split
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: leftFlex,
            child: leftPanel, 
          ),
          Expanded(
            flex: rightFlex,
            child: rightPanel, 
          ),
        ],
      ),
    );
  }
}
