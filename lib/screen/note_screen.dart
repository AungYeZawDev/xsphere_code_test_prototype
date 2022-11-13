import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xsphere_code_test_prototype/note/note_card.dart';
import 'package:xsphere_code_test_prototype/note/note_text_field.dart';
import 'package:xsphere_code_test_prototype/note/sqflite/data_base.dart';
import 'package:xsphere_code_test_prototype/note/sqflite/note_model.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String date = DateFormat.yMEd().format(DateTime.now());
  String time = DateFormat.jms().format(DateTime.now());
  List<NoteModel> notes = [];

  @override
  Widget build(BuildContext context) {
    final NoteDatabase noteDatabase =
        Provider.of<NoteDatabase>(context, listen: false);
    noteDatabase.getData().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          notes = value;
        });
      }
    });
    return Scaffold(
        backgroundColor: const Color(0xFF512f7f),
        body: notes.isEmpty
            ? const Center(
                child: Text('Empty data'),
              )
            : Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 8.6),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 60),
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    // int i = (notes.length - index) - 1;
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                            child: NoteCard(
                          date: notes[index].dateTime,
                          data: notes[index].note,
                          index: notes[index].id!,
                        )),
                      ),
                    );
                  },
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:const Color(0xff5f3d8b),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NoteTextField(
                          edit: false,
                        )),
              );
            });
          },
          child: const Icon(Icons.add,color: Colors.white,),
        ));
  }
}
