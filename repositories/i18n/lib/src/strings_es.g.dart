///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonEs common = _TranslationsCommonEs._(_root);
	@override late final _TranslationsCurrencyEs currency = _TranslationsCurrencyEs._(_root);
	@override late final _TranslationsQuoteEs quote = _TranslationsQuoteEs._(_root);
}

// Path: common
class _TranslationsCommonEs implements TranslationsCommonEn {
	_TranslationsCommonEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get error => 'Error';
	@override String get exchange => 'Cambiar';
	@override String get have => 'Tengo';
	@override String get want => 'Quiero';
}

// Path: currency
class _TranslationsCurrencyEs implements TranslationsCurrencyEn {
	_TranslationsCurrencyEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get description => {
		'BRL': 'Real (R\$)',
		'COP': 'Peso colombiano (COL\$)',
		'PEN': 'Soles Peruanos (S/)',
		'USDT': 'Tether (USDT)',
		'VES': 'Bolívares (Bs)',
	};
}

// Path: quote
class _TranslationsQuoteEs implements TranslationsQuoteEn {
	_TranslationsQuoteEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get estimated_rate => 'Tasa estimada';
	@override String get estimated_time => 'Tiempo estimado';
	@override String get no_quote => 'Sin cotización';
	@override String get you_will_receive => 'Recibirás';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.error': return 'Error';
			case 'common.exchange': return 'Cambiar';
			case 'common.have': return 'Tengo';
			case 'common.want': return 'Quiero';
			case 'currency.description.BRL': return 'Real (R\$)';
			case 'currency.description.COP': return 'Peso colombiano (COL\$)';
			case 'currency.description.PEN': return 'Soles Peruanos (S/)';
			case 'currency.description.USDT': return 'Tether (USDT)';
			case 'currency.description.VES': return 'Bolívares (Bs)';
			case 'quote.estimated_rate': return 'Tasa estimada';
			case 'quote.estimated_time': return 'Tiempo estimado';
			case 'quote.no_quote': return 'Sin cotización';
			case 'quote.you_will_receive': return 'Recibirás';
			default: return null;
		}
	}
}

