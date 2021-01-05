import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_stage_app/util/color.dart';
import 'package:note_stage_app/util/strings.dart';
import 'package:note_stage_app/util/style.dart';

class ColorSheetDialog extends StatefulWidget {
  final Function(int colorValue) getSelectedColor;

  const ColorSheetDialog({Key key, this.getSelectedColor}) : super(key: key);

  @override
  _ColorSheetDialogState createState() => _ColorSheetDialogState();
}

class _ColorSheetDialogState extends State<ColorSheetDialog> {
   Color colorValue = colorWhite;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return IntrinsicHeight(
      child: Container(
        height: 150.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color:  Color(colorValue.value),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.w),
            topRight: Radius.circular(15.w),
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectColor,
                    style: textLarge.copyWith(color: colorBlack),
                  ),
                  IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context),),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: colors.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorGray.withOpacity(0.54),
                              ),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.getSelectedColor(colors[index].value);
                                  colorValue = colors[index];
                                });

                                //Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: colors[index],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
