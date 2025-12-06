import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/shapes.dart';
import '../utils/spacing.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final double? elevation;
  
  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
    this.elevation,
  });
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.card,
      borderRadius: borderRadius ?? BorderRadius.circular(AppShapes.borderRadiusMd), // CORREGIDO
      elevation: elevation ?? 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppShapes.borderRadiusMd), // CORREGIDO
        child: Container(
          padding: padding ?? EdgeInsets.all(AppSpacing.md), // CORREGIDO
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(AppShapes.borderRadiusMd), // CORREGIDO
          ),
          child: child,
        ),
      ),
    );
  }
}