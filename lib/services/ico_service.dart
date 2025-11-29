import 'package:ewallet_app/models/ico_models.dart';
import 'package:ewallet_app/models/wallet_summary.dart';
import 'package:ewallet_app/services/api_service.dart';

class IcoService {
  final ApiService _apiService;

  IcoService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<IcoSummary> fetchSummary() async {
    final response = await _apiService.get('/ico/summary');
    if (response is Map<String, dynamic>) {
      return IcoSummary.fromJson(response);
    }
    return IcoSummary(tokenSymbol: 'ICO', price: 0, balance: 0, valuation: 0);
  }

  Future<double> fetchPrice() async {
    final response = await _apiService.get('/ico/price');
    if (response is Map<String, dynamic>) {
      return WalletSummary.parseDouble(response['price']);
    }
    return 0;
  }

  Future<IcoTradeResult> buyTokens({
    double? fiatAmount,
    double? tokenAmount,
  }) async {
    final payload = <String, dynamic>{};
    if (fiatAmount != null) payload['fiatAmount'] = fiatAmount;
    if (tokenAmount != null) payload['tokenAmount'] = tokenAmount;

    if (payload.isEmpty) {
      throw Exception('Provide fiatAmount or tokenAmount to buy tokens');
    }

    final response = await _apiService.post('/ico/buy', payload);
    if (response is Map<String, dynamic>) {
      return IcoTradeResult.fromJson(response);
    }
    throw Exception('Unexpected response from ICO buy endpoint');
  }

  Future<IcoTradeResult> sellTokens({required double tokenAmount}) async {
    final response = await _apiService.post(
      '/ico/sell',
      {'tokenAmount': tokenAmount},
    );
    if (response is Map<String, dynamic>) {
      return IcoTradeResult.fromJson(response);
    }
    throw Exception('Unexpected response from ICO sell endpoint');
  }
}
