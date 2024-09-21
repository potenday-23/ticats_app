import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticketing_site_entity.freezed.dart';
part 'ticketing_site_entity.g.dart';

@freezed
class TicketingSiteEntity with _$TicketingSiteEntity {
  const factory TicketingSiteEntity({
    @Default("") String platform,
    @Default("") String imageUrl,
    @Default("") String link,
  }) = _TicketingSiteEntity;

  factory TicketingSiteEntity.fromJson(Map<String, Object?> json) => _$TicketingSiteEntityFromJson(json);
}
