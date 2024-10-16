import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/presentation/common/app_bar/ticats_app_bar.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/presentation/event_detail/provider/event_detail_page_provider.dart';
import 'package:ticats_app/presentation/event_detail/view/event_detail_image_info_view.dart';
import 'package:ticats_app/presentation/event_detail/view/event_detail_info_view.dart';
import 'package:ticats_app/presentation/event_detail/view/event_detail_place_view.dart';
import 'package:ticats_app/presentation/event_detail/view/event_detail_recommend_events_view.dart';
import 'package:ticats_app/presentation/event_detail/view/event_detail_ticketing_site_view.dart';
import 'package:ticats_app/presentation/event_detail/view/scroll_tap_button_view.dart';

class EventDetailPage extends BasePage {
  final String title;
  final int id;

  EventDetailPage({super.key, required this.id, required this.title});

  final GlobalKey _placeViewKey = GlobalKey();

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(eventDetailPageControllerProvider(id: id)),
      data: (value) {
        final event = value.event;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: AppRadius.xxsmall,
                  child: CachedNetworkImage(
                      imageUrl: event.thumbnailImageUrl,
                      height: 411.h
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              EventDetailInfoView(event: event),
              SizedBox(height: 20.h),
              const Divider(height: 1, color: AppGrayscale.gray90),
              SizedBox(height: 20.h),
              EventDetailTicketingSiteView(ticketingSiteList: event.ticketingSiteList),
              SizedBox(height: 24.h),
              ScrollTapButtonView(onTap: () => _scrollToPlaceView()),
              SizedBox(height: 36.h),
              EventDetailImageInfoView(informationList: event.informationList),
              SizedBox(height: 36.h),
              EventDetailPlaceView(key: _placeViewKey, place: event.place),
              SizedBox(height: 36.h),
              EventDetailRecommendEventView(),
              SizedBox(height: 40.h)
            ],
          ),
        );
      },
    );
  }

  void _scrollToPlaceView() {
    Scrollable.ensureVisible(
      _placeViewKey.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => TicatsAppBar.back(title);
}