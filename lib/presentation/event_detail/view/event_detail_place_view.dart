import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/domain/entity/cultural_event/place_entity.dart';
import 'package:ticats_app/gen/assets.gen.dart';

class EventDetailPlaceView extends StatelessWidget {
  final PlaceEntity? place;
  const EventDetailPlaceView({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('장소', style: AppTypeface.label16Semibold),
          SizedBox(height: 10.h),
          Row(
            children: [
              SvgPicture.asset(Assets.icons.mapPinLine.path, width: 20.w, height: 20.w),
              SizedBox(width: 4.w),
              Text(place?.name ?? '', style: AppTypeface.label14Medium)
            ],
          ),
          SizedBox(height: 10.h),
          FittedBox(
            child: Row(
              children: [
                Text(place?.address ?? '',
                    style: AppTypeface.label14Medium.copyWith(color: AppGrayscale.gray40)
                ),
                SizedBox(width: 6.w),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: place?.address ?? ''));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('클립보드에 복사되었습니다.')),
                    );
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(Assets.icons.copy.path, width: 20.w, height: 20.w),
                      Text('주소 복사', style: AppTypeface.label12Regular.copyWith(color: AppGrayscale.gray40))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            height: 190.h,
            // TODO: 네이버 클라이언트 ID 발급 후 진행 예정
            child: NaverMap(
              options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                     target: NLatLng(place!.latitude, place!.longitude),
                     zoom: 10
                  )
              ),
            )
          )
        ],
      ),
    );
  }
}
