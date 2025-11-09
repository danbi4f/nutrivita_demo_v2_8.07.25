///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
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
	late final TranslationsAppBarEn app_bar = TranslationsAppBarEn._(_root);
	late final TranslationsWelcomeEn welcome = TranslationsWelcomeEn._(_root);

	/// en: 'What would you like to eat?'
	String get prompt_food => 'What would you like to eat?';

	late final TranslationsDrawerEn drawer = TranslationsDrawerEn._(_root);
	late final TranslationsButtonActionEn button_action = TranslationsButtonActionEn._(_root);
	late final TranslationsAlertsEn alerts = TranslationsAlertsEn._(_root);
	late final TranslationsHomePageEn home_page = TranslationsHomePageEn._(_root);
	late final TranslationsDetailsFoodEn details_food = TranslationsDetailsFoodEn._(_root);
}

// Path: app_bar
class TranslationsAppBarEn {
	TranslationsAppBarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'NutriVita'
	String get app_title => 'NutriVita';
}

// Path: welcome
class TranslationsWelcomeEn {
	TranslationsWelcomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hello $name 👋'
	String user_name({required Object name}) => 'Hello ${name}  👋';

	/// en: 'DanBi'
	String get user_name_test => 'DanBi';

	/// en: 'Hello DanBi 👋'
	String get introduce_test => 'Hello ${_root.welcome.user_name_test}  👋';
}

// Path: drawer
class TranslationsDrawerEn {
	TranslationsDrawerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Fave'
	String get fave => 'Fave';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'About the app'
	String get about => 'About the app';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Select language'
	String get select_lang => 'Select language';
}

// Path: button_action
class TranslationsButtonActionEn {
	TranslationsButtonActionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Submit'
	String get submit => 'Submit';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Confirm'
	String get confirm => 'Confirm';
}

// Path: alerts
class TranslationsAlertsEn {
	TranslationsAlertsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'no data'
	String get no_data => 'no data';

	/// en: 'error'
	String get error => 'error';
}

// Path: home_page
class TranslationsHomePageEn {
	TranslationsHomePageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Categories'
	String get categories => 'Categories';

	/// en: 'food'
	String get food => 'food';

	/// en: 'faves'
	String get faves => 'faves';
}

// Path: details_food
class TranslationsDetailsFoodEn {
	TranslationsDetailsFoodEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'rank'
	String get rank => 'rank';

	/// en: 'Food details'
	String get food_details => 'Food details';

	/// en: '100 g'
	String get k100G => '100 g';

	/// en: 'Basic information'
	String get basic_information => 'Basic information';

	/// en: 'Food class'
	String get food_class => 'Food class';

	/// en: 'FDC ID'
	String get fdc_id => 'FDC ID';

	/// en: 'Nutrients'
	String get nutrients => 'Nutrients';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return _flatMapFunction$0(path);
	}

	dynamic _flatMapFunction$0(String path) {
		switch (path) {
			case 'app_bar.app_title': return 'NutriVita';
			case 'welcome.user_name': return ({required Object name}) => 'Hello ${name}  👋';
			case 'welcome.user_name_test': return 'DanBi';
			case 'welcome.introduce_test': return 'Hello ${_root.welcome.user_name_test}  👋';
			case 'prompt_food': return 'What would you like to eat?';
			case 'drawer.home': return 'Home';
			case 'drawer.fave': return 'Fave';
			case 'drawer.settings': return 'Settings';
			case 'drawer.about': return 'About the app';
			case 'drawer.language': return 'Language';
			case 'drawer.select_lang': return 'Select language';
			case 'button_action.cancel': return 'Cancel';
			case 'button_action.ok': return 'OK';
			case 'button_action.submit': return 'Submit';
			case 'button_action.delete': return 'Delete';
			case 'button_action.confirm': return 'Confirm';
			case 'alerts.no_data': return 'no data';
			case 'alerts.error': return 'error';
			case 'home_page.categories': return 'Categories';
			case 'home_page.food': return 'food';
			case 'home_page.faves': return 'faves';
			case 'details_food.rank': return 'rank';
			case 'details_food.food_details': return 'Food details';
			case 'details_food.k100G': return '100 g';
			case 'details_food.basic_information': return 'Basic information';
			case 'details_food.food_class': return 'Food class';
			case 'details_food.fdc_id': return 'FDC ID';
			case 'details_food.nutrients': return 'Nutrients';
			default: return null;
		}
	}
}

