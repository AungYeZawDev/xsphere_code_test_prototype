import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xsphere_code_test_prototype/model/skill_model.dart';

class HiveLocalDatabase {
  bool initHiveDB = false;

  Future<void> initHive({required String para}) async {
    final Directory appDocumentsDirectory =
        await getApplicationSupportDirectory();
    Hive.init(appDocumentsDirectory.absolute.path);
    Hive.registerAdapter<SkillModel>(SkillModelAdapter());
    initHiveDB = true;
  }

  Future<SkillModel> getSkills(String para) async {
    if (initHiveDB == false) {
      await initHive(para: para);
    }
    final Box<SkillModel> skillsFromBox = await Hive.openBox(para);
    SkillModel skillsModel =
        await getFromBox(skillsFromBox, para).then((value) => value);
    return skillsModel;
  }

  Future<SkillModel> getFromBox(
      Box<SkillModel> skillsFromBox, String para) async {
    
    List<SkillModel> result = skillsFromBox.values.map((e) => e).toList();
    SkillModel skillsModel = result[0];
    return skillsModel;
  }

  Future<void> refresh(Box<SkillModel> skillsFromBox, String para) async {
    await skillsFromBox.clear();
  }
}
