import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';

class EventDetailImageInfoView extends StatefulWidget {
  final List<String>? informationList;

  const EventDetailImageInfoView({super.key, this.informationList});

  @override
  State<EventDetailImageInfoView> createState() => _EventDetailImageInfoViewState();
}

class _EventDetailImageInfoViewState extends State<EventDetailImageInfoView> {
  bool _hideImages = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('상세정보', style: AppTypeface.label16Semibold),
          SizedBox(height: 10.h),
          Stack(
            children: [
              SizedBox(
                height: _hideImages ? 846.h : null,
                child: SingleChildScrollView(
                  physics: _hideImages
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  child: Column(
                    children: widget.informationList?.map((e) =>
                        CachedNetworkImage(
                          imageUrl: e,
                          width: double.infinity,
                        )).toList() ?? []
                  ),
                ),
              ),
              if (_hideImages)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 100.h,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.white.withOpacity(0.05),              // 완전 투명
                        AppColor.white.withOpacity(0.1),   // 약간의 투명 흰색
                        AppColor.white.withOpacity(0.4),   // 중간 정도 투명 흰색
                        AppColor.white.withOpacity(0.7),   // 더 진해진 흰색
                        AppColor.white,                    // 완전 흰색
                      ],
                      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                    )
                  )
                )
              )
            ],
          ),
          SizedBox(height: _hideImages ? null : 14.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _hideImages = !_hideImages;
                });
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: AppColor.primaryLight,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.xsmall, // 모서리를 둥글게 설정
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Text(
                  _hideImages ? '더보기' : '접기',
                  style: AppTypeface.label16Semibold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
