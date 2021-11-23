import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CamDocFinderFirebaseUser {
  CamDocFinderFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

CamDocFinderFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CamDocFinderFirebaseUser> camDocFinderFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<CamDocFinderFirebaseUser>(
            (user) => currentUser = CamDocFinderFirebaseUser(user));
