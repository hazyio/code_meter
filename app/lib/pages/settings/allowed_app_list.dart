import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class AllowedAppList extends StatelessWidget {
  const AllowedAppList({super.key});
  final bool _gettingList = true;
  final bool _gettingListError = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        _showList(context);
      },
      child: Text(t.labels.seeList),
    );
  }

  void _showList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [CircularProgressIndicator()],
      ),
    );
  }
}
