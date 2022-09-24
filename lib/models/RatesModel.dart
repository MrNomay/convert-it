// To parse this JSON data, do
//
//     final rates = ratesFromJson(jsonString);

import 'dart:convert';

Rates ratesFromJson(String str) => Rates.fromJson(json.decode(str));

String ratesToJson(Rates data) => json.encode(data.toJson());

class Rates {
    Rates({
        required this.disclaimer,
        required this.license,
        required this.timestamp,
        required this.base,
        required this.rates,
    });

    String disclaimer;
    String license;
    int timestamp;
    String base;
    Map<String, double> rates;

    factory Rates.fromJson(Map<String, dynamic> json) => Rates(
        disclaimer: json["disclaimer"],
        license: json["license"],
        timestamp: json["timestamp"],
        base: json["base"],
        rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "disclaimer": disclaimer,
        "license": license,
        "timestamp": timestamp,
        "base": base,
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
