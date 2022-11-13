import 'package:flutter/material.dart';
import 'package:xsphere_code_test_prototype/note/sqflite/data_base.dart';
import 'package:xsphere_code_test_prototype/screen/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NoteDatabase(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF512f7f),
              background: const Color(0xFF512f7f)),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
