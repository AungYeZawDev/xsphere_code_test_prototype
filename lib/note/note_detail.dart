import 'package:flutter/material.dart';
import 'package:xsphere_code_test_prototype/constants/custom_constants.dart';
import 'package:xsphere_code_test_prototype/note/note_text_field.dart';
import 'package:xsphere_code_test_prototype/widgets/title_widget.dart';

class NoteDetail extends StatefulWidget {
  final int id;
  final String date;
  final String note;
  const NoteDetail(
      {Key? key, required this.id, required this.date, required this.note})
      : super(key: key);

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  CustomConstants customConstants = CustomConstants();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: const Color(0xFF512f7f),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 8,
                ),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back_ios_outlined))),
            Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 8,
                ),
                child: titleWidget('NOTE')),
            Container()
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
          child: Column(
            children: [
              const Divider(),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: widget.date,
                    style: customConstants.textStyle(
                        color: isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 229, 250, 232),
                        isDarkMode: isDarkMode,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.03)),
                const TextSpan(text: '  '),
                TextSpan(
                    text: '(LongPress the text to edit)',
                    style: customConstants.textStyle(
                        color: isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 119, 177, 164),
                        isDarkMode: isDarkMode,
                        fontWeight: FontWeight.normal,
                        fontSize: size.width * 0.03))
              ])),
              const Divider(),
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                    child: InkWell(
                      onLongPress: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteTextField(
                                      edit: true,
                                      id: widget.id,
                                      date: widget.date,
                                      data: widget.note,
                                    )),
                          );
                        });
                      },
                      child: Text(widget.note,
                          style: customConstants.textStyle(
                              color: Colors.white,
                              isDarkMode: isDarkMode,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.05)),
                    ),
                  ))),
            ],
          ),
        ),
      ]),
    );
  }
}
