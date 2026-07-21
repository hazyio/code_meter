import 'package:code_meter/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class PaddedCard extends StatelessWidget {
  const PaddedCard({
    super.key,
    required this.child,
    this.shape,
    this.padding = const EdgeInsets.all(AppSpacing.gutter),
  });

  final Widget child;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape,
      child: Padding(padding: padding, child: child),
    );
  }
}
