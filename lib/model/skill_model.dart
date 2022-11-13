import 'package:hive/hive.dart';
part 'skill_model.g.dart';

@HiveType(typeId: 0)
class SkillModel  extends HiveObject{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final String url;

  SkillModel(
      {
      required this.title,
      required this.imageUrl,
      required this.url});
}
