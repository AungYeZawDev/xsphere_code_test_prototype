import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xsphere_code_test_prototype/constants/custom_constants.dart';
import 'package:xsphere_code_test_prototype/note/sqflite/data_base.dart';
import 'package:xsphere_code_test_prototype/note/sqflite/note_model.dart';
import 'package:xsphere_code_test_prototype/widgets/title_widget.dart';

class NoteTextField extends StatefulWidget {
  final bool edit;
  final int? id;
  final String? date;
  final String? data;
  const NoteTextField(
      {Key? key, required this.edit, this.date, this.data, this.id})
      : super(key: key);

  @override
  State<NoteTextField> createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<NoteTextField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  CustomConstants customConstants = CustomConstants();
  String date = DateFormat.yMEd().format(DateTime.now());
  String time = DateFormat.jms().format(DateTime.now());

  @override
  void initState() {
    if (widget.edit) {
      textEditingController = TextEditingController(text: widget.data);
    }
    super.initState();
  }

  @override
  void dispose() {
    textEditingController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NoteDatabase noteDatabase = NoteDatabase();
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 229, 209, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 8,
                  ),
                  child: titleWidget('NOTE')),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.width * 0.03,
                  left: size.width * 0.08,
                  bottom: size.width * 0.001),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: widget.edit ? widget.date : date,
                    style: customConstants.textStyle(
                        color: isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 19, 26, 19),
                        isDarkMode: isDarkMode,
                        fontSize: size.width * 0.04)),
                const TextSpan(text: '  '),
                TextSpan(
                    text: widget.edit ? '(edit)' : time,
                    style: customConstants.textStyle(
                        color: isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 22, 170, 138),
                        isDarkMode: isDarkMode,
                        fontWeight: FontWeight.normal,
                        fontSize: size.width * 0.04))
              ])),
            ),
            Expanded(
                child: Form(
              child: Container(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    TextField(
                      key: _formKey,
                      controller: textEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 20,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.green),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "Please write note here!",
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blueGrey))),
                      style: customConstants.textStyle(
                          color: Colors.blueGrey,
                          isDarkMode: isDarkMode,
                          fontSize: size.height * 0.02),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () async {
                              if (textEditingController.text.isNotEmpty) {
                                widget.edit
                                    ? noteDatabase
                                        .updateData(NoteModel(
                                            id: widget.id,
                                            dateTime: widget.date!,
                                            note: textEditingController.text))
                                        .then((value) async {
                                        Navigator.of(context).pop();
                                      })
                                    : noteDatabase
                                        .insertData(NoteModel(
                                        dateTime: '$date  $time',
                                        note: textEditingController.text,
                                      ))
                                        .then((value) {
                                        Navigator.of(context).pop();
                                      });
                              } else {
                                buildSnackError(
                                    'Please write notes!', context, size);
                              }
                            },
                            child: const Text("Save"))
                      ],
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, context, size) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }
}
