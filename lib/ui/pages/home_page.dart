import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_stage_app/model/note_model.dart';
import 'package:note_stage_app/provider/note_provider.dart';
import 'package:note_stage_app/ui/pages/add_new_note.dart';
import 'package:note_stage_app/ui/widget/note_tile.dart';
import 'package:note_stage_app/util/color.dart';
import 'package:note_stage_app/util/strings.dart';
import 'package:note_stage_app/util/style.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    safeAreaLight;
    screenUtil(context);
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        //brightness: Brightness.dark,
        elevation: 0,
        centerTitle: true,
        backgroundColor: colorWhite,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(note, style: textLarge),
            SizedBox(
              width: 18.w,
            ),
            Text(task, style: textLarge.copyWith(color: colorBlack)),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: colorBrown,
              ),
              onPressed: () {}),
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            children: [
              StaggeredGridView.countBuilder(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisCount: 4,
                itemCount: value.notes.length,
                itemBuilder: (BuildContext context, int index) => NoteTile(
                  note: value.notes[index],
                ),
                staggeredTileBuilder: (int index) => StaggeredTile.count(
                    2,
                    value.notes[index].content.length > 100
                        ? 3
                        : (value.notes[index].content.length < 80 && value.notes[index].content.length > 30)
                            ? 2
                            : value.notes[index].content.length < 30
                                ? 1
                                : 1),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewNote(note: Note(),),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: colorWhite,
        ),
        backgroundColor: colorBrown,
      ),
    );
  }
}

