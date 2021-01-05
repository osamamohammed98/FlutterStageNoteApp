import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_stage_app/model/sqlite_helper.dart';
import 'package:note_stage_app/provider/note_provider.dart';
import 'package:note_stage_app/ui/pages/home_page.dart';
import 'package:note_stage_app/util/color.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HELPSqlite.helpSqlite.initDataBase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider<NoteProvider>(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        theme: ThemeData(
          primaryColor: colorWhite,
          scaffoldBackgroundColor: colorWhite,
        ),
        home: HomePage(),
      ),
    );
  }


}
