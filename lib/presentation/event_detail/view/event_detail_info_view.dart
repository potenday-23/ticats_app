import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_event_entity.dart';
import 'package:ticats_app/gen/assets.gen.dart';

class EventDetailInfoView extends StatelessWidget {
  final CulturalEventEntity event;

  const EventDetailInfoView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
            decoration: BoxDecoration(
              borderRadius: AppRadius.xxsmall,
              color: AppGrayscale.gray40,
            ),
            child: Text(event.categoryName, style: TextStyle(fontSize: 12.sp, color: AppGrayscale.gray99, fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: AppTypeface.label16Semibold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (event.place?.name != null) ...[
            SizedBox(height: 12.h),
            Text(event.place?.name ?? '', style: AppTypeface.label14Medium.copyWith(color: AppGrayscale.gray40))
          ],
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (event.startDate != null && event.endDate != null) ...[
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.calendar.path,
                          width: 20.w,
                          height: 20.w,
                        ),
                        SizedBox(width: 4.w),
                        Text('${DateFormat("yyyy.MM.dd").format(event.startDate!)} ~ ${DateFormat("yyyy.MM.dd").format(event.endDate!)}', style: AppTypeface.label14SemiBold)
                      ],
                    ),
                  ],
                  if (event.runningTime != null) ...[
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.timeLine.path,
                          width: 20.w,
                          height: 20.w,
                        ),
                        SizedBox(width: 4.w),
                        Text('러닝타임: ${event.runningTime}분', style: AppTypeface.label12Regular)
                      ],
                    ),
                  ],
                  if (event.viewRateName != null) ...[
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.userFill.path,
                          width: 20.w,
                          height: 20.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(event.viewRateName ?? '', style: AppTypeface.label12Regular)
                      ],
                    ),
                  ],
                ],
              ),
              Assets.icons.heartFill.svg(width: 28.w, height: 28.w)
            ],
          )
        ],
      ),
    );
  }
}
