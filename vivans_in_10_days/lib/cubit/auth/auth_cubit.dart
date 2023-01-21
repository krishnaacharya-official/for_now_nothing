import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firebase
  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _auth.currentUser;

    print("The current user is $currentUser");
    print("the current user's uid is : ${currentUser?.uid}");
    print("The current user is ${currentUser?.phoneNumber}");
    if (currentUser?.uid != null &&
        currentUser != null &&
        currentUser.uid.trim() != "") {
      emit(AuthLoggedInState(currentUser, ''));
    } else {
      emit(AuthLoggedOutState());
    }
  }

  String? _verificationId;

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthCodeSentState());
      },
      timeout: const Duration(seconds: 10),
      verificationCompleted: (phoneAuthCredential) {
        print("This smscode ${phoneAuthCredential.smsCode}");
        print("I am inside the verification complete $phoneAuthCredential");
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(getAuthErrorMessage(error)));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  static String getAuthErrorMessage(FirebaseAuthException ex) {
    if (ex.code == "invalid-verification-code") {
      return "Invalid OTP";
    } else if (ex.code == "code-expired") {
      return "Code expired. Try again with new code";
    } else if (ex.code == "internal-error") {
      return "Unknown error. Please try again after sometime";
    } else if (ex.code == "invalid-phone-number") {
      return "Invalid phone number";
    } else if (ex.code == "invalid-verification-id") {
      return "Invalid verification id";
    } else if (ex.code == "quota-exceeded") {
      return "We are receiving too many requests. Please try again after sometime";
    } else if (ex.code == "timeout") {
      return "Timeout. Please verify again";
    } else if (ex.code == "too-many-requests") {
      return "We are receiving too many requests. Try again after sometime";
    }
    return ex.message.toString();
  }

  void verifyOTP(String otp) async {
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    print("The phone credientials $credential");
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(userCredential.user!, credential.smsCode));
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(getAuthErrorMessage(ex)));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
