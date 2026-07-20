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

	/// en: 'Connect your WakaTime account and decide how coding hours convert into device usage.'
	String get welcomeDescription => 'Connect your WakaTime account and decide how coding hours convert into device usage.';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Reward Percentage'
	String get rewardPercentage => 'Reward Percentage';

	/// en: 'Allow Time Rollover'
	String get allowRollover => 'Allow Time Rollover';

	/// en: 'Unused earned time carries over to the next day.'
	String get allowRolloverDescription => 'Unused earned time carries over to the next day.';

	/// en: 'Wakatime API Key'
	String get wakaApiKey => 'Wakatime API Key';

	/// en: 'An unexpected error occurred, try again later.'
	String get unExpectedError => 'An  unexpected error occurred, try again later.';

	/// en: '1 coding hour = $convert of device time.'
	String codingTime({required Object convert}) => '1 coding hour = ${convert} of device time.';

	/// en: 'Open Source On Github'
	String get openSourceOnGithub => 'Open Source On Github';

	/// en: 'Ok'
	String get ok => 'Ok';

	/// en: 'Try Again'
	String get tryAgain => 'Try Again';

	/// en: 'Open WakaTime API page'
	String get openWakaTimeApiPage => 'Open WakaTime API page';

	/// en: 'Language'
	String get settingsLanguage => 'Language';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Apps'
	String get apps => 'Apps';

	/// en: 'Dashboard'
	String get dashboard => 'Dashboard';

	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$storage$en storage = Translations$storage$en.internal(_root);
	late final Translations$api$en api = Translations$api$en.internal(_root);
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
			'welcomeDescription' => 'Connect your WakaTime account and decide how coding hours convert into device usage.',
			'save' => 'Save',
			'rewardPercentage' => 'Reward Percentage',
			'allowRollover' => 'Allow Time Rollover',
			'allowRolloverDescription' => 'Unused earned time carries over to the next day.',
			'wakaApiKey' => 'Wakatime API Key',
			'unExpectedError' => 'An  unexpected error occurred, try again later.',
			'codingTime' => ({required Object convert}) => '1 coding hour = ${convert} of device time.',
			'openSourceOnGithub' => 'Open Source On Github',
			'ok' => 'Ok',
			'tryAgain' => 'Try Again',
			'openWakaTimeApiPage' => 'Open WakaTime API page',
			'settingsLanguage' => 'Language',
			'history' => 'History',
			'apps' => 'Apps',
			'dashboard' => 'Dashboard',
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
