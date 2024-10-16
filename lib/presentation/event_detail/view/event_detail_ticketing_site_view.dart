import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/domain/entity/cultural_event/ticketing_site_entity.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailTicketingSiteView extends StatelessWidget {
  final List<TicketingSiteEntity>? ticketingSiteList;

  const EventDetailTicketingSiteView({super.key, this.ticketingSiteList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('예매 사이트 바로가기', style: AppTypeface.label14SemiBold),
          SizedBox(height: 10.h),
          Row(
              children: ticketingSiteList
                  ?.map((e) => TicketingSiteLink(ticketingSite: e))
                  .toList() ?? [])
        ],
      ),
    );
  }
}

class TicketingSiteLink extends StatelessWidget {
  final TicketingSiteEntity ticketingSite;

  const TicketingSiteLink({super.key, required this.ticketingSite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(ticketingSite.link),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: AppRadius.xsmall,
            child: Image.asset(
              _getImagePath(ticketingSite.platform),
              width: 52.w,
              height: 52.w,
            )
          ),
          SizedBox(height: 4.h),
          Text(
              ticketingSite.platform,
              style: AppTypeface.label12Regular.copyWith(color: AppGrayscale.gray20)
          )
        ],
      ),
    );
  }

  // TODO: enum으로 변환 필요. 정확히 어떤 데이터가 내려오는지 확인 후 변환 필요
  String _getImagePath(String platform) => switch (platform) {
    '인터파크' => Assets.images.interpark.path,
    'Yes 24' => Assets.images.yes24.path,
    '네이버 예약' => Assets.images.naverReversation.path,
    '티켓링크' => Assets.images.ticketLink.path,
    '마이리얼트립' => Assets.images.myRealTrip.path,
    'CGV' => Assets.images.cgv.path,
    '메가박스' => Assets.images.megabox.path,
    '롯데 시네마' => Assets.images.lotteCinema.path,
    _ => ''
  };

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl((Uri.parse(url)))) {
      throw 'Could not launch $url';
    }
  }
}
