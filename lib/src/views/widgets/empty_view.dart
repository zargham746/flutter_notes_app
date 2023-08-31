import 'package:flutter/material.dart';
import 'package:flutter_inkflow_app/src/res/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(
                100.r,
              ),
            ),
            padding: EdgeInsets.all(20.w),
            child: Lottie.asset(
              AnimationAssets.empty,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Things look empty.Tap + to start",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
