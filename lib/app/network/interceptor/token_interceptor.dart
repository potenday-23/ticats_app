import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticats_app/app/service/auth_service.dart';
import 'package:ticats_app/domain/entity/auth/member_entity.dart';
import 'package:ticats_app/domain/usecase/auth_usecases.dart';

const _authHeaderKey = 'Authorization';

class TokenInterceptor extends InterceptorsWrapper {
  TokenInterceptor(this.ref);

  final ProviderRef ref;

  // TODO: Implement Token Refresh via User Credential
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    MemberEntity? memberInfo = ref.read(authServiceProvider).value?.memberInfo;
    memberInfo ??= await ref.read(authUseCasesProvider).loadMember.execute();

    try {
      if (memberInfo != null && options.headers['withToken'] != 'false') {
        options.headers[_authHeaderKey] = memberInfo.accessToken;
      }
      options.headers.remove('withToken');

      handler.next(options);
    } on DioException catch (e) {
      handler.reject(e);
    }
  }
}
