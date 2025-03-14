import 'package:flutter/material.dart';
import 'theme.dart';

class CustomFloatMenu extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;

  const CustomFloatMenu({
    super.key, 
    this.onPressed,
    this.icon = Icons.menu, 
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon),
    );
  }
}
