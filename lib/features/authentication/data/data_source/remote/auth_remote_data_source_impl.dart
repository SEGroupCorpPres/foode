import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:foode/core/enums/update_user.dart';
import 'package:foode/core/errors/exceptions.dart';
import 'package:foode/core/utils/constants.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/authentication/data/data_source/remote/auth_remote_data_source.dart';
import 'package:foode/features/authentication/data/model/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore,
       _firebaseStorage = firebaseStorage;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw const ServerException(
          message: 'Please try again later',
          statusCode: 'Unknown Error',
        );
      }
      var userData = await _getUserData(user.uid);
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }

      await _setUserData(user, email);
      userData = await _getUserData(user.uid);
      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.displayName:
          await _firebaseAuth.currentUser?.updateDisplayName(
            userData as String,
          );
          await _updateUserData({'fullName': userData});
        case UpdateUserAction.email:
          await _firebaseAuth.currentUser?.verifyBeforeUpdateEmail(userData as String);
          await _updateUserData({'email': userData});
        case UpdateUserAction.password:
          if (_firebaseAuth.currentUser?.email == null) {
            throw const ServerException(
              message: 'User does not exist',
              statusCode: 'Insufficient Permissions',
            );
          }
          final newData = jsonDecode(userData as String) as DataMap;
          await _firebaseAuth.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _firebaseAuth.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );
          await _firebaseAuth.currentUser?.updatePassword(
            newData['newPassword'] as String,
          );
          await _updateUserData({'password': newData['newPassword']});
        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData as String});
        case UpdateUserAction.profilePic:
          final reference = _firebaseStorage.ref().child(
            'profile_pics/${_firebaseAuth.currentUser?.uid}',
          );
          await reference.putFile(userData as File);
          final downloadURL = await reference.getDownloadURL();
          await _firebaseAuth.currentUser?.updatePhotoURL(downloadURL);
          await _updateUserData({'profilePic': downloadURL});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(fullName);
      await userCredential.user?.updatePhotoURL(kDefaultAvatar);
      await _setUserData(_firebaseAuth.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<DocumentSnapshot<DataMap>> _getUserData(String id) async {
    return _firebaseFirestore.collection('users').doc(id).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            fullName: user.displayName ?? 'User',
            profilePic: user.photoURL ?? '',
            points: 0,
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _firebaseFirestore.collection('users').doc(_firebaseAuth.currentUser?.uid).update(data);
  }
}
