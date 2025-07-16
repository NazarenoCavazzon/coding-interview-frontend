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
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsCurrencyEn currency = TranslationsCurrencyEn._(_root);
	late final TranslationsQuoteEn quote = TranslationsQuoteEn._(_root);
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get error => 'Error';
	String get exchange => 'Exchange';
	String get have => 'I have';
	String get want => 'I want';
}

// Path: currency
class TranslationsCurrencyEn {
	TranslationsCurrencyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	Map<String, String> get description => {
		'BRL': 'Real (R\$)',
		'COP': 'Colombian Peso (COL\$)',
		'PEN': 'Peruvian Soles (S/)',
		'USDT': 'Tether (USDT)',
		'VES': 'Bolívares (Bs)',
	};
}

// Path: quote
class TranslationsQuoteEn {
	TranslationsQuoteEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get estimated_rate => 'Estimated rate';
	String get estimated_time => 'Estimated time';
	String get no_quote => 'No quote';
	String get you_will_receive => 'You will receive';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.error': return 'Error';
			case 'common.exchange': return 'Exchange';
			case 'common.have': return 'I have';
			case 'common.want': return 'I want';
			case 'currency.description.BRL': return 'Real (R\$)';
			case 'currency.description.COP': return 'Colombian Peso (COL\$)';
			case 'currency.description.PEN': return 'Peruvian Soles (S/)';
			case 'currency.description.USDT': return 'Tether (USDT)';
			case 'currency.description.VES': return 'Bolívares (Bs)';
			case 'quote.estimated_rate': return 'Estimated rate';
			case 'quote.estimated_time': return 'Estimated time';
			case 'quote.no_quote': return 'No quote';
			case 'quote.you_will_receive': return 'You will receive';
			default: return null;
		}
	}
}

