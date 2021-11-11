class Student {
  String name;
  String course;
  int marks;
  String rollNo;
  String uid;
  Student({
    this.name,
    this.course,
    this.marks,
    this.rollNo,
    this.uid,
  });
  Map<String, dynamic> toMap() => {
        "Name": name,
        "Course": course,
        'rollNo': rollNo,
        'Marks': marks,
        'UID': uid,
      };
  factory Student.fromMap(Map<String, dynamic> map) => Student(
        name: map['Name'],
        course: map["Course"],
        rollNo: map['rollNo'],
        marks: map['Marks'],
        uid: map['UID'],
      );
}
