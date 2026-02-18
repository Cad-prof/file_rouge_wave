// Fichier: widgets/card_widget.dart
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const CardWidget({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: child,
    );
  }
}