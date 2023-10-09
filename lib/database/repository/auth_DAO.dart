// ignore_for_file: file_names, avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:foodhub/database/entity/verification_code.dart';

class AuthenticationDAO {
  Future<void> addVerificationCode(
      VerificationCode verificationCode, String identity) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("verification_code");
    // final snapshot = await ref.child('users/$userId').get();

    final snapshot = await ref.child(identity).get();

    if (snapshot.exists) {
      //handle code already exists
      print('ongoing already exists');
      print(snapshot.value);
      setCode(ref, identity, verificationCode);
    } else {
      print('does not exist');
      setCode(ref, identity, verificationCode);
    }
  }

  void setCode(DatabaseReference ref, String identity,
      VerificationCode verificationCode) {
    ref.set({
      identity: {
        verificationCode.toJson(),
      }
    });
  }

  bool isCodeExpired(int creationDate) {
    // Calculate the time difference between the current time and the creation date
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int elapsedTime = currentTime - creationDate;

    // Check if more than 5 minutes (300,000 milliseconds) have passed
    return elapsedTime > 300000;
  }
}

void main(List<String> args) {}
