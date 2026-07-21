///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Earn Screen Time by Coding'
	String get welcomeTitle => 'Earn Screen Time by Coding';

	late final Translations$description$en description = Translations$description$en.internal(_root);
	late final Translations$labels$en labels = Translations$labels$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$storage$en storage = Translations$storage$en.internal(_root);
	late final Translations$api$en api = Translations$api$en.internal(_root);
}

// Path: description
class Translations$description$en {
	Translations$description$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connect your WakaTime account and decide how coding hours convert into device usage.'
	String get welcome => 'Connect your WakaTime account and decide how coding hours convert into device usage.';

	/// en: 'Unused earned time carries over to the next day.'
	String get allowRollover => 'Unused earned time carries over to the next day.';

	/// en: 'Missing app? Create issue on Github to add.'
	String get reportMissingApp => 'Missing app? Create issue on Github to add.';
}

// Path: labels
class Translations$labels$en {
	Translations$labels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Code Meter'
	String get appName => 'Code Meter';

	/// en: 'Wakatime API Key'
	String get wakaApiKey => 'Wakatime API Key';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Apps'
	String get apps => 'Apps';

	/// en: 'Dashboard'
	String get dashboard => 'Dashboard';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Try Again'
	String get tryAgain => 'Try Again';

	/// en: 'Open WakaTime API page'
	String get openWakaTimeApiPage => 'Open WakaTime API page';

	/// en: 'Ok'
	String get ok => 'Ok';

	/// en: 'An unexpected error occurred, try again later.'
	String get unExpectedError => 'An  unexpected error occurred, try again later.';

	/// en: '1 coding hour = $convert of device time.'
	String codingTime({required Object convert}) => '1 coding hour = ${convert} of device time.';

	/// en: 'Open Source On Github'
	String get openSourceOnGithub => 'Open Source On Github';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Reward Percentage'
	String get rewardPercentage => 'Reward Percentage';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Allow Time Rollover'
	String get allowRollover => 'Allow Time Rollover';

	/// en: 'Time Remaining'
	String get timeRemaining => 'Time Remaining';

	/// en: '${hour}h ${minutes}m'
	String timeCount({required Object hour, required Object minutes}) => '${hour}h ${minutes}m';

	/// en: 'Earned'
	String get earned => 'Earned';

	/// en: 'Used'
	String get used => 'Used';

	/// en: 'Sync with WakaTime'
	String get syncWithWakaTime => 'Sync with WakaTime';

	/// en: 'Last synced: $datetime'
	String lastSynced({required Object datetime}) => 'Last synced: ${datetime}';

	/// en: 'Top Used Apps'
	String get topUsedApps => 'Top Used Apps';

	/// en: 'Getting apps...'
	String get gettingApps => 'Getting apps...';

	/// en: 'All'
	String get all => 'All';

	/// en: 'System'
	String get system => 'System';

	/// en: 'Installed'
	String get installed => 'Installed';

	/// en: 'Allowed'
	String get allowed => 'Allowed';

	/// en: 'Not Allowed'
	String get notAllowed => 'Not Allowed';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings saved'
	String get saved => 'Settings saved';

	/// en: 'Failed to save settings $error'
	String failedToSave({required Object error}) => 'Failed to save settings ${error}';
}

// Path: storage
class Translations$storage$en {
	Translations$storage$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to retrieve saved API key'
	String get failedToGetApiKey => 'Failed to retrieve saved API key';

	/// en: 'Failed to retrieve saved reward value'
	String get failedToGetReward => 'Failed to retrieve saved reward value';

	/// en: 'Failed to retrieve saved rollover value'
	String get failedToGetRollover => 'Failed to retrieve saved rollover value';

	/// en: 'Failed to save API key'
	String get failedToSaveApiKey => 'Failed to save API key';

	/// en: 'Failed to save reward value'
	String get failedToSaveReward => 'Failed to save reward value';

	/// en: 'Failed to save rollover value'
	String get failedToSaveRollover => 'Failed to save rollover value';
}

// Path: api
class Translations$api$en {
	Translations$api$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$api$validation$en validation = Translations$api$validation$en.internal(_root);
	late final Translations$api$responses$en responses = Translations$api$responses$en.internal(_root);
}

// Path: api.validation
class Translations$api$validation$en {
	Translations$api$validation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'API key cannot be empty'
	String get cannotBeEmpty => 'API key cannot be empty';

	/// en: 'Api key must start with 'waka_''
	String get mustStartWithWaka => 'Api key must start with \'waka_\'';

	/// en: 'Api key must be at least 20 characters long'
	String get atLeast20Characters => 'Api key must be at least 20 characters long';

	/// en: 'Api key cannot be longer than 50 characters'
	String get atMost50Characters => 'Api key cannot be longer than 50 characters';

	/// en: 'Api key can only contain letters, numbers, and underscores'
	String get inValid => 'Api key can only contain letters, numbers, and underscores';
}

// Path: api.responses
class Translations$api$responses$en {
	Translations$api$responses$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Permission denied to read stats'
	String get permissionDenied => 'Permission denied to read stats';

	/// en: 'Too many requests, try again in a few seconds'
	String get tooManyRequests => 'Too many requests, try again in a few seconds';

	/// en: 'Server failed, try again later.'
	String get serverFailed => 'Server failed, try again later.';

	/// en: '404? something isn't right, update app or create a issue.'
	String get notFoundError => '404? something isn\'t right, update app or create a issue.';

	/// en: 'Network error: $error'
	String networkError({required Object error}) => 'Network error: ${error}';

	/// en: 'A bad request happened'
	String get badRequest => 'A bad request happened';

	/// en: 'Api key is invalid.'
	String get unAuthorized => 'Api key is invalid.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'welcomeTitle' => 'Earn Screen Time by Coding',
			'description.welcome' => 'Connect your WakaTime account and decide how coding hours convert into device usage.',
			'description.allowRollover' => 'Unused earned time carries over to the next day.',
			'description.reportMissingApp' => 'Missing app? Create issue on Github to add.',
			'labels.appName' => 'Code Meter',
			'labels.wakaApiKey' => 'Wakatime API Key',
			'labels.history' => 'History',
			'labels.apps' => 'Apps',
			'labels.dashboard' => 'Dashboard',
			'labels.settings' => 'Settings',
			'labels.tryAgain' => 'Try Again',
			'labels.openWakaTimeApiPage' => 'Open WakaTime API page',
			'labels.ok' => 'Ok',
			'labels.unExpectedError' => 'An  unexpected error occurred, try again later.',
			'labels.codingTime' => ({required Object convert}) => '1 coding hour = ${convert} of device time.',
			'labels.openSourceOnGithub' => 'Open Source On Github',
			'labels.language' => 'Language',
			'labels.rewardPercentage' => 'Reward Percentage',
			'labels.save' => 'Save',
			'labels.allowRollover' => 'Allow Time Rollover',
			'labels.timeRemaining' => 'Time Remaining',
			'labels.timeCount' => ({required Object hour, required Object minutes}) => '${hour}h ${minutes}m',
			'labels.earned' => 'Earned',
			'labels.used' => 'Used',
			'labels.syncWithWakaTime' => 'Sync with WakaTime',
			'labels.lastSynced' => ({required Object datetime}) => 'Last synced: ${datetime}',
			'labels.topUsedApps' => 'Top Used Apps',
			'labels.gettingApps' => 'Getting apps...',
			'labels.all' => 'All',
			'labels.system' => 'System',
			'labels.installed' => 'Installed',
			'labels.allowed' => 'Allowed',
			'labels.notAllowed' => 'Not Allowed',
			'settings.saved' => 'Settings saved',
			'settings.failedToSave' => ({required Object error}) => 'Failed to save settings ${error}',
			'storage.failedToGetApiKey' => 'Failed to retrieve saved API key',
			'storage.failedToGetReward' => 'Failed to retrieve saved reward value',
			'storage.failedToGetRollover' => 'Failed to retrieve saved rollover value',
			'storage.failedToSaveApiKey' => 'Failed to save API key',
			'storage.failedToSaveReward' => 'Failed to save reward value',
			'storage.failedToSaveRollover' => 'Failed to save rollover value',
			'api.validation.cannotBeEmpty' => 'API key cannot be empty',
			'api.validation.mustStartWithWaka' => 'Api key must start with \'waka_\'',
			'api.validation.atLeast20Characters' => 'Api key must be at least 20 characters long',
			'api.validation.atMost50Characters' => 'Api key cannot be longer than 50 characters',
			'api.validation.inValid' => 'Api key can only contain letters, numbers, and underscores',
			'api.responses.permissionDenied' => 'Permission denied to read stats',
			'api.responses.tooManyRequests' => 'Too many requests, try again in a few seconds',
			'api.responses.serverFailed' => 'Server failed, try again later.',
			'api.responses.notFoundError' => '404? something isn\'t right, update app or create a issue.',
			'api.responses.networkError' => ({required Object error}) => 'Network error: ${error}',
			'api.responses.badRequest' => 'A bad request happened',
			'api.responses.unAuthorized' => 'Api key is invalid.',
			_ => null,
		};
	}
}
