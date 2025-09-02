// lib/presentation/provider/auth/auth_state_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_doit/app/enum/auth_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  Stream<AuthStatus> build() async* {
    final auth = FirebaseAuth.instance;

    await for (final firebaseUser in auth.authStateChanges()) {
      if (firebaseUser == null) {
        yield AuthStatus.signedOut;
      } else {
        // TODO: 레이어 계층 분리해야함
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        if (userDoc.exists) {
          yield AuthStatus.signedInAndRegistered;
        } else {
          yield AuthStatus.signedInButNotRegistered;
        }
      }
    }
  }
}
