class WalletSummary {
  final double balance;
  final String currency;
  final double totalCredited;
  final double totalDebited;

  const WalletSummary({
    required this.balance,
    required this.currency,
    required this.totalCredited,
    required this.totalDebited,
  });

  factory WalletSummary.fromJson(Map<String, dynamic> json) {
    return WalletSummary(
      balance: parseDouble(json['balance']),
      currency: (json['currency'] ?? '').toString().isNotEmpty
          ? json['currency'].toString()
          : 'USD',
      totalCredited: parseDouble(json['totalCredited']),
      totalDebited: parseDouble(json['totalDebited']),
    );
  }

  String get currencySymbol {
    switch (currency.toUpperCase()) {
      case 'INR':
        return '₹';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      default:
        return currency;
    }
  }

  static double parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }
}
