class NoteModel {
  int? id;
  String dateTime = '';
  String note = '';

  NoteModel({this.id, required this.dateTime, required this.note});
  String get date => dateTime;
  String get data => note;

  set date(String newDate) {
    dateTime = newDate;
  }

  set data(String newData) {
    note = newData;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['date_time'] = dateTime;
    map['note'] = note;

    return map;
  }

  NoteModel.fromMapObject(Map<String, dynamic> map,) {
    id = map['id'];
    dateTime = map['date_time'];
    note = map['note'];
  }
}
