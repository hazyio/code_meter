import 'package:code_meter/components/error_box.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/database.dart';
import 'package:flutter/material.dart';

class AllowedAppList extends StatefulWidget {
  const AllowedAppList({super.key, required this.database});
  final DatabaseHelper database;
  @override
  State<AllowedAppList> createState() => _AllowedAppListState();
}

class _AllowedAppListState extends State<AllowedAppList> {
  bool _gettingList = true;
  bool _gettingListError = true;

  @override
  void initState() {
    super.initState();
    _getList();
  }

  Future<void> _getList([StateSetter? setModalState]) async {
    void update(VoidCallback fn) {
      setModalState != null ? setModalState(fn) : setState(fn);
    }

    update(() {
      _gettingList = true;
      _gettingListError = false;
    });
    await Future.delayed(const Duration(seconds: 2));
    const appList = await widget.database.getAllowedApps();
    update(() {
      _gettingList = false;
      _gettingListError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        _showList(context);
      },
      child: Text(t.labels.seeList),
    );
  }

  List<Widget> _listData(BuildContext context, StateSetter setModalState) {
    if (_gettingList) {
      return [
        const SizedBox(
          height: 150,
          width: .infinity,
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }
    if (_gettingListError) {
      return [
        const SizedBox(height: AppSpacing.marginTablet),
        ErrorBox(
          children: [
            Text(t.errors.failedLoadAllowedList),
            const SizedBox(height: AppSpacing.margin),
            TextButton(
              onPressed: () => _getList(setModalState),
              child: Text(t.labels.tryAgain),
            ),
            const SizedBox(height: AppSpacing.marginTablet),
          ],
        ),
      ];
    }
    return [];
  }

  void _showList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: _listData(context, setModalState),
        ),
      ),
    );
  }
}
