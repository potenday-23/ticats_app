import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:ticats_app/app/config/app_const.dart';
import 'package:ticats_app/data/model/auth/member_model.dart';
import 'package:ticats_app/domain/entity/auth/member_info_entity.dart';
import 'package:ticats_app/domain/entity/auth/sso_login_entity.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "${AppConst.baseUrl}/members")
abstract class AuthAPI {
  factory AuthAPI(Dio dioBuilder) = _AuthAPI;

  @GET("/me")
  Future<MemberModel> getMe();

  @POST("/nickname-validation")
  @Headers({'showError': "false"})
  Future<void> getNickValid(@Body() Map<String, String> request);

  @POST("/login")
  Future<MemberModel> login(@Body() SsoLoginEntity oauthLogin);

  @POST("/fcm-token")
  @Headers({'showError': "false"})
  Future<void> setFCMToken(@Body() Map<String, String> request);

  @POST("/info")
  Future<MemberModel> setUserInfo(@Body() MemberInfoEntity memberInfo);
}
