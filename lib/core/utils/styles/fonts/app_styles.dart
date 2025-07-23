import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app_strings/app_strings.dart';
import '../color/app_colors.dart';

abstract class AppStyles {
  static TextStyle styleRegular16(context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold20(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle styleBold22(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 22),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle styleBold26(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 26),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle styleBold30(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 30),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle styleMedium16(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMedium17(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMedium18(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMedium20(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleSemiBold16(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold20(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold22(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 22),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleRegular12(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleSemiBold24(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleRegular14(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleSemiBold18(BuildContext context) {
    return TextStyle(
      color: AppColors.black,
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: AppStrings.fontFamily,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleBold24(BuildContext context) {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    );
  }
}

// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  double width = MediaQuery.sizeOf(context).width;
  if (width < SizeConfig.tablet) {
    return width / 550;
  } else if (width < SizeConfig.desktop) {
    return width / 1000;
  } else {
    return width / 1920;
  }
}

class SizeConfig {
  static const double desktop = 1200;
  static const double tablet = 800;

  static late double width, height;

  static init(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
  }
}
