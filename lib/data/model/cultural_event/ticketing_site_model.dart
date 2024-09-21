import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticats_app/domain/entity/cultural_event/ticketing_site_entity.dart';

part 'ticketing_site_model.freezed.dart';
part 'ticketing_site_model.g.dart';

@freezed
class TicketingSiteModel with _$TicketingSiteModel {
  const factory TicketingSiteModel({
    @Default("") String platform,
    @Default("") String imageUrl,
    @Default("") String link,
  }) = _TicketingSiteModel;

  factory TicketingSiteModel.fromJson(Map<String, Object?> json) => _$TicketingSiteModelFromJson(json);
}

extension TicketingSiteModelX on TicketingSiteModel {
  TicketingSiteEntity toEntity() {
    return TicketingSiteEntity(
      platform: platform,
      imageUrl: imageUrl,
      link: link,
    );
  }
}
