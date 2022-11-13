import 'package:flutter/material.dart';
import 'package:xsphere_code_test_prototype/constants/custom_constants.dart';
import 'package:xsphere_code_test_prototype/note/note_detail.dart';
import 'package:xsphere_code_test_prototype/note/note_text_field.dart';
import 'package:xsphere_code_test_prototype/note/sqflite/data_base.dart';

class NoteCard extends StatefulWidget {
  final int index;
  final String date;
  final String data;

  const NoteCard({
    super.key,
    required this.date,
    required this.data,
    required this.index,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

enum Options { edit, delete }

class _NoteCardState extends State<NoteCard> {
  var popupMenuItemIndex = 0;
  CustomConstants customConstants = CustomConstants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final NoteDatabase noteDatabase = NoteDatabase();
    PopupMenuItem buildPopupMenuItem(Text text, Icon icon, int position) {
      return PopupMenuItem(
        value: position,
        child: Row(
          children: [
            icon,
            text,
          ],
        ),
      );
    }

    onMenuItemSelected(int value, int index) {
      setState(() {
        popupMenuItemIndex = value;
      });
      if (value == Options.edit.index) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteTextField(
                      edit: true,
                      id: widget.index,
                      date: widget.date,
                      data: widget.data,
                    )),
          );
        });
      } else {
        noteDatabase.deleteData(index);
      }
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteDetail(
                      id: widget.index,
                      date: widget.date,
                      note: widget.data,
                    )),
          );
        });
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width / 60,
            left: MediaQuery.of(context).size.width / 60,
            right: MediaQuery.of(context).size.width / 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  widget.date,
                  style: customConstants.textStyle(
                      color: isDarkMode
                          ? Colors.white
                          : const Color.fromARGB(255, 16, 17, 16),
                      isDarkMode: isDarkMode,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.03),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    onMenuItemSelected(value as int, widget.index);
                  },
                  itemBuilder: (BuildContext context) => [
                    buildPopupMenuItem(
                        const Text('Edit'),
                        const Icon(
                          Icons.mode_edit_outline_outlined,
                          color: Colors.black,
                        ),
                        Options.edit.index),
                    buildPopupMenuItem(
                        const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                        const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                        Options.delete.index),
                  ],
                  child: const Icon(Icons.more_vert_outlined),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30.0),
              child: Text(
                widget.data,
                maxLines: 2,
                style: customConstants.textStyle(
                    color: isDarkMode ? Colors.white : Colors.blueGrey,
                    isDarkMode: isDarkMode,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.03),
              ),
            )
          ],
        ),
      ),
    );
  }
}
