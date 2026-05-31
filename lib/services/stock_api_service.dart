import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class StockApiService {
  final Dio _dio = Dio();
  static const String finnhubBase = 'https://finnhub.io/api/v1';
  // 请替换为你的 Finnhub API Key
  final String apiKey = 'YOUR_FINNHUB_API_KEY';

  Future<Map<String, dynamic>> getQuote(String symbol) async {
    try {
      final response = await _dio.get(
        '$finnhubBase/quote',
        queryParameters: {'symbol': symbol, 'token': apiKey},
      );
      return response.data;
    } catch (e) {
      // 备用：腾讯财经接口（对中国股票更友好）
      return await _getTencentQuote(symbol);
    }
  }

  Future<Map<String, dynamic>> _getTencentQuote(String symbol) async {
    // 示例：腾讯股票接口
    try {
      final response = await _dio.get('https://qt.gtimg.cn/q=$symbol');
      // 解析腾讯数据（简化版）
      return {'price': 0.0, 'change': 0.0}; // 实际需解析
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  WebSocketChannel connectWebSocket() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.finnhub.io?token=$apiKey'),
    );
    return channel;
  }
}
