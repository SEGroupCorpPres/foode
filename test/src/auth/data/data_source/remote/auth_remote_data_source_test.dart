import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foode/core/enums/update_user.dart';
import 'package:foode/core/errors/exceptions.dart';
import 'package:foode/core/utils/constants.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/authentication/data/data_source/remote/auth_remote_data_source.dart';
import 'package:foode/features/authentication/data/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:foode/features/authentication/data/model/user_model.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_remote_data_source.mock.dart';

void main() {
  late FirebaseStorage firebaseStorage;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firebaseFirestore;
  late AuthRemoteDataSource authRemoteDataSource;
  late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;
  late MockUser mockUser;
  const tUser = LocalUserModel.empty();
  setUp(() async {
    firebaseStorage = MockFirebaseStorage();
    firebaseAuth = MockFirebaseAuth();
    firebaseFirestore = FakeFirebaseFirestore();
    // final googleSignIn = MockGoogleSignIn();
    // final signInAccount = await googleSignIn.signIn();
    // final googleAuth = await signInAccount!.authentication;
    // final AuthCredential credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
    // Sign in.
    documentReference = firebaseFirestore.collection('users').doc();
    await documentReference.set(
      tUser.copyWith(uid: documentReference.id).toMap(),
    );
    mockUser = MockUser()..uid = documentReference.id;
    userCredential = MockUserCredential(mockUser);
    // firebaseAuth = MockFirebaseAuth(mockUser: mockUser);
    // final result = await firebaseAuth.signInWithCredential(credential);
    // final user = result.user;
    authRemoteDataSource = AuthRemoteDataSourceImpl(
      firebaseStorage: firebaseStorage,
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );
    when(() => firebaseAuth.currentUser).thenReturn(mockUser);
  });

  const tPassword = 'Test Password';
  const tEmail = 'testemail@email.com';
  const tFullName = 'Test Full Name';
  final tFirebaseAuthException = FirebaseAuthException(
    code: 'user-not-found',
    message:
        'There is no user record corresponding to this identifier. The user may have been deleted.',
  );

  group('signIn', () {
    test(
      'should return [LocalUserModel] when no [Exception] is thrown',
      () async {
        //   average
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => userCredential);
        final result = await authRemoteDataSource.signIn(
          email: tEmail,
          password: tPassword,
        );
        expect(result.uid, userCredential.user!.uid);
        expect(result.points, 0);
        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );
    test(
      'should throw [ServerException] when user is null after sign in',
      () async {
        final emptyUserCredential = MockUserCredential();
        //   average
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => emptyUserCredential);
        final call = authRemoteDataSource.signIn;
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );
    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
      () async {
        //   average
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);
        final call = authRemoteDataSource.signIn;
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );
  });

  group('forgotPassword', () {
    test(
      'should complete successfully when no [Exception] is thrown',
      () async {
        //   average
        when(
          () => firebaseAuth.sendPasswordResetEmail(email: any(named: 'email')),
        ).thenAnswer((_) async => Future.value());
        final call = authRemoteDataSource.forgotPassword(tEmail);
        expect(call, completes);
        verify(
          () => firebaseAuth.sendPasswordResetEmail(email: tEmail),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );
    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
      () async {
        //   average
        when(
          () => firebaseAuth.sendPasswordResetEmail(email: any(named: 'email')),
        ).thenThrow(tFirebaseAuthException);
        final call = authRemoteDataSource.forgotPassword;
        expect(() => call(tEmail), throwsA(isA<ServerException>()));
        verify(
          () => firebaseAuth.sendPasswordResetEmail(email: tEmail),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );
  });
  group('signUp', () {
    test(
      'should complete successfully when no [Exception] is thrown',
      () async {
        //   average
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => userCredential);
        when(
          () => userCredential.user?.updateDisplayName(any()),
        ).thenAnswer((_) async => Future.value());
        when(
          () => userCredential.user?.updatePhotoURL(any()),
        ).thenAnswer((_) async => Future.value());
        final call = authRemoteDataSource.signUp(
          email: tEmail,
          password: tPassword,
          fullName: tFullName,
        );
        expect(call, completes);
        verify(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        await untilCalled(() => userCredential.user?.updateDisplayName(any()));
        await untilCalled(() => userCredential.user?.updatePhotoURL(any()));
        verify(
          () => userCredential.user?.updateDisplayName(tFullName),
        ).called(1);
        verify(
          () => userCredential.user?.updatePhotoURL(kDefaultAvatar),
        ).called(1);

        verifyNoMoreInteractions(firebaseAuth);
      },
    );
    test(
      'should throw [ServerException] when user is null after sign in',
      () async {
        final emptyUserCredential = MockUserCredential();
        //   average
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => emptyUserCredential);
        final call = authRemoteDataSource.signIn;
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );
    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
      () async {
        //   average
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);
        final call = authRemoteDataSource.signUp;
        expect(
          () => call(email: tEmail, password: tPassword, fullName: tFullName),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );
  });
  group('updateUser', () {
    setUp(() {
      // when(() => firebaseAuth.currentUser).thenReturn(mockUser);
      // mockUser = MockUser()..uid = documentReference.id;

      registerFallbackValue(MockAuthCredential());
    });
    test(
      'should update user displayName successfully when no [Exception] is thrown',
      () async {
        //   average
        when(
          () => mockUser.updateDisplayName(any()),
        ).thenAnswer((_) async => Future.value());
        await authRemoteDataSource.updateUser(
          action: UpdateUserAction.displayName,
          userData: tFullName,
        );
        verify(() => mockUser.updateDisplayName(tFullName)).called(1);
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
        verifyNever(() => mockUser.updatePassword(any()));
        final userData = await firebaseFirestore.collection('users').doc(mockUser.uid).get();
        expect(userData.data()!['fullName'], tFullName);
      },
    );
    test(
      'should update user email successfully when no [Exception] is thrown',
      () async {
        //   average
        when(
          () => mockUser.verifyBeforeUpdateEmail(any()),
        ).thenAnswer((_) async => Future.value());
        await authRemoteDataSource.updateUser(
          action: UpdateUserAction.email,
          userData: tEmail,
        );
        verify(() => mockUser.verifyBeforeUpdateEmail(tEmail)).called(1);
        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updatePassword(any()));
        final userData = await firebaseFirestore.collection('users').doc(mockUser.uid).get();
        expect(userData.data()!['email'], tEmail);
      },
    );
    test(
      'should update user bio successfully when no [Exception] is thrown',
      () async {
        //   average
        const newBio = 'new bio';
        await authRemoteDataSource.updateUser(
          action: UpdateUserAction.bio,
          userData: newBio,
        );
        final userData = await firebaseFirestore
            .collection('users')
            .doc(documentReference.id)
            .get();
        expect(userData.data()!['bio'], newBio);
        // verifyZeroInteractions(mockUser);
        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
        verifyNever(() => mockUser.updatePassword(any()));
      },
    );
    test(
      'should update user password successfully when no [Exception] is thrown',
      () async {
        //   average
        when(
          () => mockUser.updatePassword(any()),
        ).thenAnswer((_) async => Future.value());
        when(
          () => mockUser.reauthenticateWithCredential(any()),
        ).thenAnswer((_) async => userCredential);
        when(() => mockUser.email).thenReturn(tEmail);
        await authRemoteDataSource.updateUser(
          action: UpdateUserAction.password,
          userData: jsonEncode({
            'oldPassword': 'oldPassword',
            'newPassword': tPassword,
          }),
        );
        verify(() => mockUser.updatePassword(tPassword));
        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
        final userData = await firebaseFirestore
            .collection('users')
            .doc(documentReference.id)
            .get();
        expect(userData.data()!['password'], tPassword);
      },
    );
    // test(
    //   'should update user profilePic successfully when no [Exception] is thrown',
    //       () async {
    //     //   average
    //         final newProfilePic  = ;
    //     when(
    //           () => mockUser.updateDisplayName(any()),
    //     ).thenAnswer((_) async => Future.value());
    //     await authRemoteDataSource.updateUser(
    //       action: UpdateUserAction.displayName,
    //       userData: tFullName,
    //     );
    //     verify(() => mockUser.updateDisplayName(tFullName)).called(1);
    //     verifyNever(() => mockUser.updatePhotoURL(any()));
    //     verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
    //     verifyNever(() => mockUser.updatePassword(any()));
    //     final userData = await firebaseFirestore.collection('users').doc(mockUser.uid).get();
    //     expect(userData.data()!['fullName'], tFullName);
    //   },
    // );
    // test(
    //   'should throw [ServerException] when user is null after sign in',
    //       () async {
    //     final emptyUserCredential = MockUserCredential();
    //     //   average
    //     when(
    //           () =>
    //           firebaseAuth.signInWithEmailAndPassword(
    //             email: any(named: 'email'),
    //             password: any(named: 'password'),
    //           ),
    //     ).thenAnswer((_) async => emptyUserCredential);
    //     final call = authRemoteDataSource.signIn;
    //     expect(
    //           () => call(email: tEmail, password: tPassword),
    //       throwsA(isA<ServerException>()),
    //     );
    //     verify(
    //           () =>
    //           firebaseAuth.signInWithEmailAndPassword(
    //             email: tEmail,
    //             password: tPassword,
    //           ),
    //     ).called(1);
    //     verifyNoMoreInteractions(firebaseAuth);
    //   },
    // );
    // test(
    //   'should throw [ServerException] when [FirebaseAuthException] is thrown',
    //       () async {
    //     //   average
    //     when(
    //           () =>
    //           firebaseAuth.createUserWithEmailAndPassword(
    //             email: any(named: 'email'),
    //             password: any(named: 'password'),
    //           ),
    //     ).thenThrow(tFirebaseAuthException);
    //     final call = authRemoteDataSource.signUp;
    //     expect(
    //           () =>
    //           call(email: tEmail, password: tPassword, fullName: tFullName),
    //       throwsA(isA<ServerException>()),
    //     );
    //     verify(
    //           () =>
    //           firebaseAuth.createUserWithEmailAndPassword(
    //             email: tEmail,
    //             password: tPassword,
    //           ),
    //     ).called(1);
    //     verifyNoMoreInteractions(firebaseAuth);
    //   },
    // );
  });
}
