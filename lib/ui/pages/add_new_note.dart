import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_stage_app/model/note_model.dart';
import 'package:note_stage_app/provider/note_provider.dart';
import 'package:note_stage_app/ui/widget/bottom_sheet_dialog.dart';
import 'package:note_stage_app/util/color.dart';
import 'package:note_stage_app/util/strings.dart';
import 'package:note_stage_app/util/style.dart';
import 'package:provider/provider.dart';

class AddNewNote extends StatefulWidget {
  Note note;

  AddNewNote({Key key, this.note}) : super(key: key);

  @override
  _AddNewNoteState createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  var date =
      "${DateTime.now().year} / ${DateTime.now().month}/ ${DateTime.now().day} ";
  var color = colorWhite;
  TextEditingController _controllerTitle, _controllerContent;
  final keyScaffoled = GlobalKey<ScaffoldState>();

  NoteProvider readProvider;

  @override
  void initState() {
    super.initState();
    _controllerTitle = TextEditingController();
    widget.note.title != null ? _controllerTitle.text = widget.note.title : "";

    _controllerContent = TextEditingController();
    widget.note.content != null
        ? _controllerContent.text = widget.note.content
        : "";

    widget.note.note_color != null
        ? color = Color(widget.note.note_color)
        : color;

    widget.note.date_created != null ? date = widget.note.date_created : date;

    readProvider = context.read<NoteProvider>();
  }

  @override
  Widget build(BuildContext context) {
    safeAreaLight;
    screenUtil(context);

    return Scaffold(
      key: keyScaffoled,
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: colorWhite,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(date,
                  textAlign: TextAlign.start,
                  style: textLarge.copyWith(color: colorGray, fontSize: 12)),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.palette_outlined,
                color: colorGray,
              ),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: colorTrans,
                  elevation: 10,
                  isDismissible: true,
                  context: context,
                  builder: (context) => ColorSheetDialog(
                    getSelectedColor: (colorValue) {
                      print(colorValue);
                      setState(() {
                        color = Color(colorValue);
                      });
                    },
                  ),
                );
              }),
          widget.note.note_color == null
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: colorGray,
                  ),
                  onPressed: () async {
                    await readProvider
                        .deleteFromDatabase(widget.note)
                        .whenComplete(() {
                      showSnackBar(keyScaffoled, successContent, colorGreen);
                      Navigator.pop(context);
                    });
                  },
                ),
          IconButton(
              icon: Icon(
                Icons.done,
                color: colorGray,
              ),
              onPressed: () async {
                //todo this for update
                widget.note.id == null ? addNote() : updateNote();
                //todo this for add
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: color,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              TextField(
                controller: _controllerTitle,
                maxLines: 1,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  hintText: hintTitle,
                  hintStyle: textHint,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              TextField(
                controller: _controllerContent,
                maxLines: 100,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  hintText: hintTitle,
                  hintStyle: textHint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(
      GlobalKey<ScaffoldState> keyScaffoled, String content, Color colorRed) {
    keyScaffoled.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            content,
            style: textHint.copyWith(color: colorWhite),
          ),
          backgroundColor: colorRed,
        ),
      );
  }

  updateNote() async {
    print(
        "${widget.note.id} ${widget.note.title}  ${widget.note.content} ${widget.note.date_created}");

    await readProvider
        .updateDatabase(Note(
            note_color: color.value,
            date_created: date,
            content: _controllerContent.text,
            title: _controllerTitle.text,
            id: widget.note.id))
        .whenComplete(() {
      showSnackBar(keyScaffoled, successContent, colorGreen);
      Navigator.pop(context);
    });
  }

  addNote() async {
    if (_controllerTitle.text.isEmpty && widget.note.id == null) {
      showSnackBar(keyScaffoled, errorTitle, colorRed);
      return;
    }
    if (_controllerContent.text.isEmpty && widget.note.id == null) {
      showSnackBar(keyScaffoled, errorContent, colorRed);
      return;
    }

    await readProvider
        .insertToDatabase(
      Note(
          title: _controllerTitle.text,
          content: _controllerContent.text,
          date_created: date,
          note_color: color.value),
    )
        .whenComplete(() {
      showSnackBar(keyScaffoled, successContent, colorGreen);
      Navigator.pop(context);
    });
  }
}
