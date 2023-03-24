import 'package:cloud_firestore/cloud_firestore.dart';

class Subject {
  final int sid;
  final String sub_name;
  final String sub_code;
  final int semester;

  const Subject({
    required this.sid,
    required this.sub_name,
    required this.sub_code,
    required this.semester,
  });
  factory Subject.fromjson(Map<dynamic, dynamic> json) {
    return Subject(
        sid: json['sid'],
        sub_name: json['sub_name'],
        sub_code: json['sub_code'],
        semester: json['semester']);
  }
  Map<dynamic, dynamic> toJson() => {
        'sid': sid,
        'sub_name': sub_name,
        'sub_code': sub_code,
        'semester': semester
      };
  static Subject fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<dynamic, dynamic>;
    return Subject(
      sid: snapshot['sid'],
      sub_name: snapshot['sub_name'],
      sub_code: snapshot['sub_code'],
      semester: snapshot['semester'],
    );
  }
}
