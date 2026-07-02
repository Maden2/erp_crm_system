import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../manager/profits_cubit.dart';

class ProfitsHeaderSection extends StatelessWidget {
  final String selectedTimeFrame;

  const ProfitsHeaderSection({
    super.key,
    required this.selectedTimeFrame,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: 12.h,
            bottom: 12.h,
            right: 24.w,
            left: 24.w,
          ),
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.authBgColor,
                      size: 24.w,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "الأرباح",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Color(0xffEFF2FE),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white30,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 14.w,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "نطاق مخصص",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 14.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ["سنوي", "شهري", "يومي"].map((filter) {
                          final isSelected = selectedTimeFrame == filter;

                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<ProfitsCubit>()
                                  .changeTimeFrame(filter);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 6.w,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 9.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.r),
                                border: isSelected
                                    ? null
                                    : Border.all(
                                  color: Colors.white30,
                                ),
                              ),
                              child: Text(
                                filter,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: isSelected
                                      ? const Color(0xff0D256F)
                                      : Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}