import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';import 'package:note_stage_app/model/note_model.dart';
import 'package:note_stage_app/ui/pages/add_new_note.dart';
import 'package:note_stage_app/util/color.dart';
import 'package:note_stage_app/util/style.dart';
class NoteTile extends StatelessWidget {
  final Note note;

  const NoteTile({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = _determineFontSizeForContent();
    screenUtil(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewNote(
                note: note,
              ),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: Color(note.note_color),
          borderRadius: BorderRadius.circular(15.w),
          boxShadow: [
            BoxShadow(
              color: colorBlack.withOpacity(0.4),
              blurRadius: 30,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              note.title,
              maxLines: 10,
              style: textHint.copyWith(
                  color: colorBlack,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 6.h,
            ),
            Expanded(
              child: AutoSizeText(
                note.content,
                style: textHint.copyWith(
                    color: colorBlack,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400),
                maxLines: 10,
                textScaleFactor: 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }

  double _determineFontSizeForContent() {
    int charCount = note.content.length + note.title.length;
    double fontSize = 20;
    if (charCount > 110) {
      fontSize = 12;
    } else if (charCount > 80) {
      fontSize = 14;
    } else if (charCount > 50) {
      fontSize = 16;
    } else if (charCount > 20) {
      fontSize = 18;
    }
    return fontSize;
  }
}
