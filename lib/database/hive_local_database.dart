import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xsphere_code_test_prototype/model/skill_model.dart';

class HiveLocalDatabase {
  bool initHiveDB = false;

  Future<void> initHive() async {
    final Directory appDocumentsDirectory =
        await getApplicationSupportDirectory();
    Hive.init(appDocumentsDirectory.absolute.path);
    Hive.registerAdapter<SkillModel>(SkillModelAdapter());
    initHiveDB = true;
  }

  Future<List<SkillModel>> getSkills() async {
    List<SkillModel> skillsModel = [];
    if (initHiveDB == false) {
      await initHive();
    }
    final Box<SkillModel> skillsFromBox = await Hive.openBox('skills');
    await getFromBox(skillsFromBox).then((value) => skillsModel = value);
    return skillsModel;
  }

  Future<List<SkillModel>> getFromBox(Box<SkillModel> skillsFromBox) async {
    List<SkillModel> result = skillsFromBox.values.toList().reversed.toList();
    print(result);
    if (result.isEmpty) {
      await skillsFromBox.add(SkillModel(
          title: 'Flutter',
          imageUrl:
              'https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png',
          url: 'https://flutter.dev/'));
      await skillsFromBox.add(SkillModel(
          title: 'Laravel',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Laravel.svg/985px-Laravel.svg.png',
          url: 'https://laravel.com/'));
      await skillsFromBox.add(SkillModel(
          title: 'NodeJS',
          imageUrl:
              'https://img.favpng.com/16/11/19/node-js-javascript-web-application-express-js-computer-software-png-favpng-cYmJvJyBDcTNbLdSRdNAceLyW.jpg',
          url: 'https://nodejs.org/en/'));
      await skillsFromBox.add(SkillModel(
          title: 'React',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/2300px-React-icon.svg.png',
          url: 'https://reactjs.org/'));
    }
    List<SkillModel> skills = skillsFromBox.values.toList().reversed.toList();
    print(skills[0].imageUrl);
    return skills;
  }

  Future addSkill(SkillModel skillModel) async {
    final Box<SkillModel> skillsFromBox = await Hive.openBox('skills');
    await skillsFromBox.add(skillModel);
  }

  Future deleteSkill(var para) async {
    final Box<SkillModel> skillsFromBox = await Hive.openBox('skills');
    await skillsFromBox.delete(para);
  }
}
