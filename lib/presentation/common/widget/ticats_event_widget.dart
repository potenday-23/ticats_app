import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/ticats_event_category.enum.dart';
import 'package:ticats_app/app/enum/ticats_event_status.enum.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/gen/assets.gen.dart';

import 'ticats_event_status_chip.dart';

class TicatsEventWidget extends ConsumerWidget {
  const TicatsEventWidget({
    required this.event,
    required this.width,
    required this.imageHeight,
    this.status = TicatsEventStatus.ticketOpen,
    this.hasCategoryChip = false,
    super.key,
  });

  factory TicatsEventWidget.small({
    required CulturalEventEntity event,
  }) =>
      TicatsEventWidget(
        event: event,
        width: 132.w,
        imageHeight: 174.w,
        status: event.isOpened ?? false
            ? TicatsEventStatus.ticketOpen
            : TicatsEventStatus.ticketReservation,
        hasCategoryChip: true,
      );

  factory TicatsEventWidget.big({
    required CulturalEventEntity event,
  }) =>
      TicatsEventWidget(
        event: event,
        width: 167.w,
        imageHeight: 221.w,
        status: event.isOpened ?? false
            ? TicatsEventStatus.ticketOpen
            : TicatsEventStatus.ticketReservation,
      );

  final CulturalEventEntity event;
  final TicatsEventStatus status;
  final double width;
  final double imageHeight;
  final bool hasCategoryChip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.push('/eventDetail');
      },
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: AppRadius.xxsmall,
                  child: CachedNetworkImage(imageUrl: event.thumbnailImageUrl, height: imageHeight),
                ),
                if (hasCategoryChip) ...[
                  Positioned.fill(
                    left: 10.w,
                    top: 10.w,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: buildCategoryChip(
                        TicatsEventCategory.values.firstWhere(
                          (e) => e.label == event.categoryName,
                          orElse: () => TicatsEventCategory.values.first,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: AppTypeface.label14Bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 2.w),
                Center(child: Assets.icons.heartFill.svg(width: 24.w, height: 24.w)),
              ],
            ),
            SizedBox(height: 4.h),
            // TODO: big일 때는 Row, small일 때는 Column으로 분기 필요
            if (status == TicatsEventStatus.ticketReservation) ...[
              FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TicatsEventStatusChip(),
                    SizedBox(height: 4.h),
                    Text(
                      event.ticketOpenDate != null ? DateFormat("yyyy.MM.dd hh:mm").format(event.ticketOpenDate!) : "",
                      style: AppTypeface.label12Bold.copyWith(color: AppColor.systemError),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
            ],
            Text(event.placeName ?? "", style: AppTypeface.label12Regular),
            if (status == TicatsEventStatus.ticketOpen) ...[
              Text(
                "${DateFormat("yyyy.MM.dd").format(event.startDate!)} ~ ${DateFormat("yyyy.MM.dd").format(event.endDate!)}",
                style: AppTypeface.label12SemiBold,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildCategoryChip(TicatsEventCategory type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppGrayscale.gray10.withOpacity(0.8),
        borderRadius: AppRadius.xxsmall,
      ),
      child: Text(
        type.label,
        style: AppTypeface.label12SemiBold.copyWith(color: Colors.white),
      ),
    );
  }
}
