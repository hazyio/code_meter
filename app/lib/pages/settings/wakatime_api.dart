import 'package:code_meter/components/full_width.dart';
import 'package:code_meter/components/loading_button.dart';
import 'package:code_meter/gen/i18n/strings.g.dart';
import 'package:code_meter/theme/app_dimens.dart';
import 'package:code_meter/utils/api.dart';
import 'package:code_meter/utils/from_theme.dart';
import 'package:code_meter/utils/misc.dart';
import 'package:code_meter/utils/result.dart';
import 'package:code_meter/utils/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class WakatimeApi extends StatefulWidget {
  const WakatimeApi({super.key});
  @override
  State<WakatimeApi> createState() => _WakatimeApiPageState();
}

class _WakatimeApiPageState extends State<WakatimeApi> {
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  bool _isProcessing = false;
  bool _canEdit = false;
  String _formerApiKey = "";
  late TextEditingController _wakaTimeApiController;
  String? _apiKeyError;

  @override
  void initState() {
    super.initState();
    _wakaTimeApiController = TextEditingController();
    SettingsRepository().getApiKey().then((value) {
      if (value != null) {
        setState(() {
          _wakaTimeApiController.text = value;
          _formerApiKey = value;
        });
      }
    });
  }

  @override
  void dispose() {
    _wakaTimeApiController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    final translation = t;
    if (_formKey.currentState!.validate()) {
      if (_formerApiKey == _wakaTimeApiController.text) {
        showSnackBar(context, translation.description.apiKeySameAsPrevious);
        return;
      }
      setState(() => _isProcessing = true);
      final result = await validateApiKeyRemote(_wakaTimeApiController.text);

      switch (result) {
        case Ok():
          {
            final saveSettings = await SettingsRepository().saveApiKey(
              _wakaTimeApiController.text,
            );
            if (!mounted) return;
            setState(() {
              _isProcessing = false;
              _formerApiKey = _wakaTimeApiController.text;
              _canEdit = false;
            });
            if (saveSettings) {
              showSnackBar(context, translation.settings.saved);
            } else {
              showSnackBar(
                context,
                translation.settings.failedToSave(
                  error: translation.labels.unExpectedError,
                ),
                actionLabel: translation.labels.tryAgain,
              );
            }
          }
        case Err(error: final e):
          {
            setState(() => _isProcessing = false);
            if (!mounted) return;
            showSnackBar(
              context,
              translation.settings.failedToSave(error: e),
              actionLabel: translation.labels.tryAgain,
              onPressed: () async {
                await _saveSettings();
              },
            );
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translation = t;
    final theme = Theme.of(context);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        children: [
          FullWidth(
            child: Text(
              translation.labels.wakaApiKey,
              style: fromTextTheme(theme).labelLarge,
            ),
          ),
          const SizedBox(height: AppSpacing.margin),
          TextFormField(
            controller: _wakaTimeApiController,
            obscureText: !_isVisible,
            enabled: !_isProcessing && _canEdit,
            decoration: InputDecoration(
              errorText: _apiKeyError,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.content_paste, size: 20),
                    onPressed: () async {
                      final clipboardData = await Clipboard.getData(
                        'text/plain',
                      );
                      if (clipboardData?.text != null) {
                        _wakaTimeApiController.text = clipboardData!.text!;
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      _isVisible ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _isVisible = !_isVisible),
                  ),
                ],
              ),
            ),
            validator: (value) {
              if (value == _formerApiKey) {
                return null;
              }

              final keyCheck = validateApiKeyLocal(value ?? '');
              switch (keyCheck) {
                case Ok():
                  return null;
                case Err(error: final e):
                  return e;
              }
            },
          ),
          const SizedBox(height: AppSpacing.marginTablet),
          FullWidth(
            child: _canEdit
                ? Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _canEdit = false;
                          });
                        },
                        child: Text(translation.labels.cancel),
                      ),
                      const SizedBox(width: AppSpacing.gutter),
                      Expanded(
                        child: LoadingButton(
                          isLoading: _isProcessing,
                          onPressed: _saveSettings,
                          child: Text(translation.labels.save),
                        ),
                      ),
                    ],
                  )
                : OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _canEdit = true;
                      });
                    },
                    child: Text(translation.labels.editApiKey),
                  ),
          ),
        ],
      ),
    );
  }
}
