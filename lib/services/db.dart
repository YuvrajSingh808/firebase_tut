import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future writeStudent(Student student) async {
    CollectionReference ref = firestore.collection('students');
    await ref.doc(student.uid).set(student.toMap());
    // return docRef.id;
  }

  Future<List<Student>> readAllStudentOnce() async {
    CollectionReference ref = firestore.collection('students');
    QuerySnapshot snap = await ref.get();
    List<Student> students = [];
    for (var document in snap.docs) {
      students.add(Student.fromMap(document.data()));
    }
    return students;
  }

  Future updateStudent(String docId) async {
    CollectionReference ref = firestore.collection('students');
    await ref.doc(docId).update({'Marks': 89});
  }

  Future<List<Student>> readCSEStudent() async {
    Query query =
        firestore.collection('students').where('Course', isEqualTo: 'CSE');
    QuerySnapshot snap = await query.get();
    List<Student> students = [];
    for (var document in snap.docs) {
      students.add(Student.fromMap(document.data()));
    }
    return students;
  }

  Stream readAllStudents() {
    CollectionReference ref = firestore.collection('students');
    Stream collectionStream = ref.snapshots();
    return collectionStream;
  }
}
