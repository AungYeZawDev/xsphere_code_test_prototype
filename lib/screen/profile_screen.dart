import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xsphere_code_test_prototype/constants/custom_constants.dart';
import 'package:xsphere_code_test_prototype/model/about_model.dart';
import 'package:xsphere_code_test_prototype/model/skill_model.dart';
import 'package:xsphere_code_test_prototype/utils/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CustomConstants _customConstants = CustomConstants();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String aboutText = '';
  ServiceApi serviceApi = ServiceApi();
  bool _switchValue = true;
  List<SkillModel> listSkillModel = [
    SkillModel(
        title: 'Flutter',
        imageUrl:
            'https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png',
        url: 'https://flutter.dev/'),
    SkillModel(
        title: 'Laravel',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Laravel.svg/985px-Laravel.svg.png',
        url: 'https://laravel.com/'),
    SkillModel(
        title: 'NodeJS',
        imageUrl:
            'https://img.favpng.com/16/11/19/node-js-javascript-web-application-express-js-computer-software-png-favpng-cYmJvJyBDcTNbLdSRdNAceLyW.jpg',
        url: 'https://nodejs.org/en/'),
    SkillModel(
        title: 'React',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/2300px-React-icon.svg.png',
        url: 'https://reactjs.org/')
  ];

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void _showSkillDialog(BuildContext context) {
    final GlobalKey<FormState> titleKey = GlobalKey<FormState>();
    final GlobalKey<FormState> logoKey = GlobalKey<FormState>();
    final GlobalKey<FormState> linkKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController logoController = TextEditingController();
    TextEditingController linkController = TextEditingController();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Add skills'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextFormField('title', titleKey, titleController),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildTextFormField('logo url', logoKey, logoController),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildTextFormField('link', linkKey, linkController),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                MaterialButton(
                  color: Colors.blueGrey,
                  onPressed: () async {},
                  child: Text(
                    'add',
                    style: _customConstants.textStyle(
                        color: Colors.white, isDarkMode: false, fontSize: 14),
                  ),
                )
              ],
            ));
  }

  TextFormField _buildTextFormField(
          String label, Key key, TextEditingController controller) =>
      TextFormField(
          key: key,
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.blueGrey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
          ));

  void _showAboutDialog(BuildContext context, String text) {
    TextEditingController textEditingController =
        TextEditingController(text: text);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("About me"),
          content: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    key: _formKey,
                    controller: textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 20,
                    maxLength: 500,
                    expands: false,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.green),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Please write",
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.blueGrey))),
                    style: _customConstants.textStyle(
                        color: Colors.blueGrey,
                        isDarkMode: false,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            MaterialButton(
              color: Colors.blueGrey,
              child: Text(
                "update",
                style: _customConstants.textStyle(
                    color: Colors.white, isDarkMode: false, fontSize: 14),
              ),
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                  await serviceApi
                      .updateAbout('About me', textEditingController.text)
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                } else {
                  buildSnackError('Please write', context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final double coverHeight = height / 2.5;
    final double profileHeight = height / 6;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(padding: EdgeInsets.zero, children: <Widget>[
        buildTop(coverHeight, profileHeight),
        buildContent()
      ]),
    );
  }

  Widget buildTop(double coverHeight, double profileHeight) {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: bottom),
              child: buildCover(coverHeight)),
          Positioned(
              left: 10,
              top: 50,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: (() => Navigator.of(context).pop()),
              )),
          Positioned(top: top, child: buildProfileImage(profileHeight)),
        ]);
  }

  Widget buildContent() => Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            'John Doe',
            style: _customConstants.textStyle(
                color: Colors.black,
                isDarkMode: false,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'Flutter Developer',
            style: _customConstants.textStyle(
                color: Colors.blueGrey, isDarkMode: false, fontSize: 12),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  children: [
                    Text(
                      'Skills',
                      style: _customConstants.textStyle(
                          color: Colors.black,
                          isDarkMode: false,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          _showSkillDialog(context);
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.blueGrey,
                        ))
                  ],
                ),
              )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: listSkillModel.map((e) => buildSkills(e)).toList()),
          const SizedBox(
            height: 16,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  children: [
                    Text(
                      'About me',
                      style: _customConstants.textStyle(
                          color: Colors.black,
                          isDarkMode: false,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () => _showAboutDialog(context, aboutText),
                        icon: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.blueGrey,
                        ))
                  ],
                ),
              )),
          buildAbout(),
        ],
      );
  Widget buildAbout() => FutureBuilder<AboutModel>(
      future: serviceApi.getAbout(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          aboutText = snapshot.data!.data[0].description;
          return SizedBox(
            width: MediaQuery.of(context).size.width / 1.16,
            height: MediaQuery.of(context).size.height / 3.5,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                aboutText,
                style: _customConstants.textStyle(
                    color: Colors.black, isDarkMode: false, fontSize: 14),
              ),
            ),
          );
        } else {
          const Center(
            child: Text('Error'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  Widget buildSkills(SkillModel item) => InkWell(
        onTap: () => _launchInBrowser(Uri.parse(item.url)),
        child: Tooltip(
          message: item.title,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Image.network(
                fit: BoxFit.cover, width: 40, height: 40, item.imageUrl),
          ),
        ),
      );
  Widget buildCover(double coverHeight) => Container(
      height: coverHeight,
      decoration: const BoxDecoration(
          color: Color(0xFF512f7f),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35.0),
              bottomRight: Radius.circular(35.0))),
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _switchValue?'Available' :'Currently Working',
            style: _customConstants.textStyle(
                color: Colors.white, isDarkMode: false, fontSize: 24),
          ),
          const SizedBox(width: 15,),
          CupertinoSwitch(
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
          ),
        ],
      )));

  Widget buildProfileImage(double profileHeight) => Hero(
        tag: 'profile',
        child: CircleAvatar(
          radius: profileHeight / 2,
          backgroundColor: Colors.grey.shade800,
          backgroundImage: AssetImage(_customConstants.assetImage),
        ),
      );
}
