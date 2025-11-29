import 'package:ewallet_app/models/wallet_summary.dart';

class IcoSummary {
  final String tokenSymbol;
  final double price;
  final double balance;
  final double valuation;

  IcoSummary({
    required this.tokenSymbol,
    required this.price,
    required this.balance,
    required this.valuation,
  });

  factory IcoSummary.fromJson(Map<String, dynamic> json) {
    return IcoSummary(
      tokenSymbol: (json['tokenSymbol'] ?? 'ICO').toString(),
      price: WalletSummary.parseDouble(json['price']),
      balance: WalletSummary.parseDouble(json['balance']),
      valuation: WalletSummary.parseDouble(json['valuation']),
    );
  }
}

class PaymentSession {
  final String endpoint;
  final String requestPayload;
  final String checksum;

  const PaymentSession({
    required this.endpoint,
    required this.requestPayload,
    required this.checksum,
  });

  bool get isValid =>
      endpoint.isNotEmpty && requestPayload.isNotEmpty && checksum.isNotEmpty;

  factory PaymentSession.fromJson(Map<String, dynamic> json) {
    return PaymentSession(
      endpoint: (json['endpoint'] ?? '').toString(),
      requestPayload: (json['request'] ?? '').toString(),
      checksum: (json['checksum'] ?? '').toString(),
    );
  }
}

class IcoTradeResult {
  final String id;
  final String status;
  final double tokenAmount;
  final double fiatAmount;
  final PaymentSession? paymentSession;

  IcoTradeResult({
    required this.id,
    required this.status,
    required this.tokenAmount,
    required this.fiatAmount,
    this.paymentSession,
  });

  factory IcoTradeResult.fromJson(Map<String, dynamic> json) {
    final transaction = json['transaction'];
    Map<String, dynamic> tx =
        transaction is Map<String, dynamic> ? transaction : json;

    return IcoTradeResult(
      id: (tx['_id'] ?? tx['id'] ?? '').toString(),
      status: (tx['status'] ?? 'pending').toString(),
      tokenAmount: WalletSummary.parseDouble(tx['tokenAmount']),
      fiatAmount: WalletSummary.parseDouble(tx['fiatAmount']),
      paymentSession: json['paymentSession'] is Map<String, dynamic>
          ? PaymentSession.fromJson(
              json['paymentSession'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
