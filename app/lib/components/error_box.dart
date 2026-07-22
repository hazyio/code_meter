import 'package:code_meter/components/padded_card.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 32,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: AppSpacing.gutter),
          ...children,
        ],
      ),
    );
  }
}
