import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pet_perfect/woof/model/woof_model.dart';

class WoofRepo {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://random.dog/woof.json';

  Future<Woof?> fetchWoof() async {
    final response = await _dio.get(_baseUrl);
    return Woof.fromJson(response.data);
  }
}
