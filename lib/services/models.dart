class Student {
  String name;
  String course;
  int marks;
  String rollNo;
  Student({
    this.name,
    this.course,
    this.marks,
    this.rollNo,
  });
  Map<String, dynamic> toMap() => {
        "Name": name,
        "Course": course,
        'rollNo': rollNo,
        'Marks': marks,
      };
  factory Student.fromMap(Map<String, dynamic> map) => Student(
        name: map['Name'],
        course: map["Course"],
        rollNo: map['rollNo'],
        marks: map['Marks'],
      );
    
}
