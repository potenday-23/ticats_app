import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/app_bar/ticats_app_bar.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/presentation/event_detail/provider/event_detail_page_provider.dart';

import '../../app/config/app_color.dart';

class EventDetailPage extends BasePage {
  final int id;

  const EventDetailPage(this.id, {super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(eventDetailPageControllerProvider(id: id)),
      data: (value) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: AppRadius.xxsmall,
                  child: CachedNetworkImage(
                      imageUrl: 'https://ticketimage.interpark.com/Play/image/large/24/24006225_p.gif',
                      height: 411.h
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.xxsmall,
                        color: AppGrayscale.gray40,
                      ),
                      child: Text("뮤지컬", style: TextStyle(fontSize: 12.sp, color: AppGrayscale.gray99, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '뮤지컬 <디어 에반 핸슨>(Dear Evan Hansen) 최대글자수 2줄까지하면 웬만하면 충분하겠지? 가나다라마',
                            style: AppTypeface.label16Semibold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text("충무아트센터 대극장", style: AppTypeface.label14Medium),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Text('2024.03.28 ~ 2024.06.23', style: AppTypeface.label14SemiBold)
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Text('러닝타임: 160분', style: AppTypeface.label12Regular)
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Text("전체관람가", style: AppTypeface.label12Regular)
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: AppGrayscale.gray90),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('예매 사이트 바로가기', style: AppTypeface.label14SemiBold),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => TicatsAppBar.back('title');
}