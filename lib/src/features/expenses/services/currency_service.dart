import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:json_annotation/json_annotation.dart';

class CurrencyService {
  const CurrencyService();

  static const supportedCurrencies = <Currency>[
    Currency.usd,
    Currency.aed,
    Currency.eur,
    Currency.gbp,
    Currency.inr,
  ];

  // TODO: Expose a helper that wraps getMyCurrency() from the currency
  // package to infer the locale-specific default for onboarding.
  Future<double> convert({
    required double amount,
    required Currency from,
    Currency to = Currency.usd,
  }) async {
    final usdAmount = await CurrencyConverter.convert(
      from: from,
      to: to,
      amount: amount,
    );

    if (usdAmount == null) {
      throw const CurrencyConversionException();
    }

    return usdAmount;
  }
}

class CurrencyConversionException implements Exception {
  const CurrencyConversionException();
}

//json serializable
class CurrencyJsonConverter implements JsonConverter<Currency, String> {
  const CurrencyJsonConverter();

  @override
  Currency fromJson(String json) => Currency.values.byName(json);

  @override
  String toJson(Currency object) => object.name;
}

extension CurrencyExtension on Currency {
  static const _currencySymbols = <Currency, String>{
    Currency.usd: r'$',
    Currency.aed: '\uE001',
    Currency.eur: '€',
    Currency.gbp: '£',
    Currency.inr: '₹',
  };
  String get symbol => _currencySymbols[this] ?? name;
}
