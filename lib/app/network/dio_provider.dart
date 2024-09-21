import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ticats_app/app/config/app_const.dart';

import 'interceptor/token_interceptor.dart';

part 'dio_provider.g.dart';

const Duration connectionTimeOutMls = Duration(milliseconds: 10000);
const Duration readTimeOutMls = Duration(milliseconds: 10000);
const Duration writeTimeOutMls = Duration(milliseconds: 10000);

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final Dio dio = Dio();

  dio.options = BaseOptions(
    responseType: ResponseType.json,
    baseUrl: AppConst.baseUrl,
    contentType: Headers.jsonContentType,
    connectTimeout: connectionTimeOutMls,
    receiveTimeout: readTimeOutMls,
    sendTimeout: writeTimeOutMls,
  );

  // Add interceptor for logging(talker)
  final talker = Talker();
  dio.interceptors.add(TalkerDioLogger(talker: talker));

  // Add interceptor for token handling
  dio.interceptors.add(TokenInterceptor(ref));

  return dio;
}
