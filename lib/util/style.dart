import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_stage_app/util/color.dart';

screenUtil(BuildContext context) {
  ScreenUtil.init(context,
      width: 392.72727272727275,
      height: 803.6363636363636,
      allowFontScaling: true);
}

var safeAreaLight =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: colorWhite,
  statusBarColor: colorTrans,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
));

var textLarge = TextStyle(
  color: colorBrown,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.33,
  fontSize: 24,
);

var textHint = TextStyle(
color: colorGray,
fontSize: 14,
letterSpacing: 1.33,
fontWeight: FontWeight.w500,
);