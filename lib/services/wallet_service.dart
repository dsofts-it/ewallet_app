import 'package:ewallet_app/models/wallet_summary.dart';
import 'package:ewallet_app/services/api_service.dart';

class WalletService {
  final ApiService _apiService;

  WalletService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<WalletSummary> fetchSummary() async {
    final response = await _apiService.get('/wallet/summary');
    final wallet = response is Map<String, dynamic>
        ? response['wallet'] ?? response
        : <String, dynamic>{};
    if (wallet is Map<String, dynamic>) {
      return WalletSummary.fromJson(wallet);
    }
    return const WalletSummary(
      balance: 0,
      currency: 'USD',
      totalCredited: 0,
      totalDebited: 0,
    );
  }

  Future<Map<String, dynamic>> fetchTransactions({int page = 1}) async {
    final result = await _apiService.get('/wallet/transactions?page=$page');
    return result is Map<String, dynamic> ? result : <String, dynamic>{};
  }

  Future<Map<String, dynamic>> requestTopup({
    required double amount,
    String redirectUrl = 'myapp://wallet/success',
  }) async {
    final result = await _apiService.post(
      '/wallet/topup',
      {
        'amount': amount,
        'redirectUrl': redirectUrl,
      },
    );
    return result is Map<String, dynamic> ? result : <String, dynamic>{};
  }
}
