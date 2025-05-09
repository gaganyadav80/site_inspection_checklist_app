import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderSide = BorderSide.none,
  });

  final Widget child;
  final VoidCallback onPressed;
  final BorderSide borderSide;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.grey.shade800),
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            side: borderSide,
            borderRadius: kDefaultBorderRadius,
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
