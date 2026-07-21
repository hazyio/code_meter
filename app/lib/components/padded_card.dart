import 'package:code_meter/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class PaddedCard extends StatelessWidget {
  const PaddedCard({
    super.key,
    required this.child,
    this.shape,
    this.margin,
    this.padding = const EdgeInsets.all(AppSpacing.gutter),
  });

  final Widget child;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      shape: shape,
      child: Padding(padding: padding, child: child),
    );
  }
}
