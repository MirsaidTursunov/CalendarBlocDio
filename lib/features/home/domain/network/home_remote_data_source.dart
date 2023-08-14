import 'dart:convert';

import 'package:calendar_app/core/server_error.dart';
import 'package:calendar_app/features/home/data/models/get_colors_response.dart';
import 'package:calendar_app/features/home/data/models/get_date_response.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final dio = Dio()..options = BaseOptions(
    contentType: 'application/json',
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 30),
  )..interceptors.addAll(
    [
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    ],
  );

  Future<GetDateResponse> fetchDate() async {
    try {
      final response = await dio.get<dynamic>(
        'https://jsonkeeper.com/b/ADYD',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return GetDateResponse.fromJson(response.data);
      }
      throw ServerException.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: 'Something went wrong!');
    }
  }

  Future<List<GetColorsResponse>?> fetchColors() async {
    try {
      final response = await dio.get<List<dynamic>>(
        'https://jsonkeeper.com/b/N5M6',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final parsedData = response.data;
        return parsedData?.map((jsonObject) {
          return GetColorsResponse.fromJson(jsonObject);
        }).toList();
      }
      throw ServerException.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: 'Something went wrong!');
    }
  }
}
