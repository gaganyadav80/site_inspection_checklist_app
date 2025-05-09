import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.white),
        backgroundColor: WidgetStateProperty.all(kPrimaryColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: kDefaultBorderRadius,
          ),
        ),
      ),
      child: child,
    );
  }
}
