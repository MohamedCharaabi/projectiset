import 'package:auth/ui/views/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User> get authStateChanges => _auth.authStateChanges();

  //collection firestore
  CollectionReference refrenceProfs =
      FirebaseFirestore.instance.collection("professors");
  CollectionReference refrenceStudents =
      FirebaseFirestore.instance.collection("students");

  Future<void> signUp(
      {String email, String password, String username, bool isStudent}) async {
    IsStudent student = IsStudent();

    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (isStudent == null) {
        isStudent = student.isStudent;
      }

      //create collections
      isStudent
          ? await addUser(refrenceStudents, username, email, "Ti14", userData)
          : await addProfessor(refrenceProfs, username, email, userData);

      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(User);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> addUser(CollectionReference users, String username, String email,
      String classRoom, UserCredential userCredential) {
    // Call the user's CollectionReference to add a new user
    User user = userCredential.user;
    return users
        .doc(classRoom)
        .collection(user.uid)
        .add({
          'full_name': username, // John Doe
          'email': email
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addProfessor(CollectionReference users, String username,
      String email, UserCredential userCredential) {
    // Call the user's CollectionReference to add a new user
    User user = userCredential.user;
    return users
        .doc(user.uid)
        .set({
          'full_name': username, // John Doe
          'email': email
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
