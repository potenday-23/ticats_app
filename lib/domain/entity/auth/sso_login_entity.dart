import 'package:freezed_annotation/freezed_annotation.dart';

part 'sso_login_entity.freezed.dart';
part 'sso_login_entity.g.dart';

@freezed
class SsoLoginEntity with _$SsoLoginEntity {
  const factory SsoLoginEntity({
    required String socialId,
    required String socialType,
    required String email,
  }) = _SsoLoginEntity;
  factory SsoLoginEntity.fromJson(Map<String, Object?> json) => _$SsoLoginEntityFromJson(json);
}
