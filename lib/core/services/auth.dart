import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:strength_project/core/models/user.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthService with ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  User _user;
  Status _status = Status.Uninitialized;

  AuthService.instance() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  AuthService();

  Status get status => _status;

  Future<void> _onAuthStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = _userFromFirebaseUser(user);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _firebaseAuth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // sign in with email and password
  Future<String> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // _user = _userFromFirebaseUser(result.user);
      FirebaseUser _user = result.user;
      return _user.uid;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      debugPrint(e.toString());
      return null;
    }
  }

  // register with email and password
  Future<String> signUp(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      debugPrint(e.toString());
      return null;
    }
  }

  // get current firebaseuser model as a User Model
  Future<User> getCurrentUser() async {
    try {
      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      _user = _userFromFirebaseUser(currentUser);
      return _user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // get userId of user model
  Future<String> getUserId() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    _user = _userFromFirebaseUser(user);
    return _user?.uid;
  }

  // sign out
  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      _status = Status.Unauthenticated;
      notifyListeners();
      return Future.delayed(Duration.zero);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // send email verification
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  // check if email verification is done
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  // reset password
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
