import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_details/utils/constants/themes/app_color.dart';
import 'package:student_details/utils/constants/validators.dart';
import 'package:student_details/utils/widgets/new_text_form_field.dart';
import '../utils/widgets/new_elevated_button.dart';
import '../view/home_page.dart';
import '../view/login_view.dart';

class AuthController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isLogin = false;
  bool _isVisible = false;
  final auth = FirebaseAuth.instance;

  bool get isLogin => _isLogin;

  bool get isVisible => _isVisible;

  createAuth(BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      final authRef = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      User? user = authRef.user;
      if (user!.uid.isNotEmpty) {
        navigator.pushReplacementNamed('/home');
        Fluttertoast.showToast(msg: "SIGN UP SUCCESSFUL");

      } else {
        Fluttertoast.showToast(msg: "Authentication Error");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      } else {
        Fluttertoast.showToast(msg: 'Error: ${e.message}');
      }
    }
    notifyListeners();
  }

  loginAuth(BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      final authRef = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      User? user = authRef.user;

      if (user!.uid.isNotEmpty) {
        navigator.pushReplacementNamed('/home');
        Fluttertoast.showToast(msg: "LOGIN SUCCESSFUL");

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        Fluttertoast.showToast(msg: 'Invalid email format');
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        Fluttertoast.showToast(msg: "email or password is wrong");
      } else if (e.code == "user-not-found") {
        Fluttertoast.showToast(msg: "User not found");
      } else if (e.code == "wrong-password") {
        Fluttertoast.showToast(msg: "Incorrect password");
      } else if (e.code == "user-disabled") {
        Fluttertoast.showToast(msg: "User account has been disabled");
      } else {
        Fluttertoast.showToast(msg: "An error occurred: ${e.message}");
      }
    }
    notifyListeners();
  }

  signInWithGoogle(BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = authResult.user;
        if (user != null) {
          navigator.pushReplacementNamed('/home');
          Fluttertoast.showToast(msg: "GOOGLE SIGN IN SUCCESSFUL");

        } else {
          Fluttertoast.showToast(
              msg: "Google sign in failed", gravity: ToastGravity.BOTTOM);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error during sign-in: $e');
      return null;
    }
    notifyListeners();
    return null;
  }

  signInWithMobile(number, BuildContext context) async {
    try {
      final navigator = Navigator.of(context);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final UserCredential authResult =
              await auth.signInWithCredential(credential);
          User? user = authResult.user;
          if (user != null) {
            navigator.pushReplacementNamed('/home');

          } else {
            Fluttertoast.showToast(msg: "ERROR LOGIN WITH PHONE NUMBER");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Fluttertoast.showToast(
                msg: 'The provided phone number is not valid.');
          } else if (e.code == 'invalid-verification-code') {
            Fluttertoast.showToast(
                msg: 'The provided verification code is not valid.');
          } else if (e.code == 'too-many-requests') {
            Fluttertoast.showToast(
                msg: 'Too many verification attempts. Please try again later.');
          } else {
            Fluttertoast.showToast(
                msg: 'Error during phone number verification: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = '';
          showDialog(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 250, bottom: 250, left: 25, right: 25),
                child: Card(
                  color: AppColor.bodyColor,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 60),
                        child: Container(decoration: BoxDecoration(border:Border.all(color: AppColor.appBarColor,width: 5),borderRadius: BorderRadius.circular(10),color: AppColor.appBarColor),
                          child: Card(elevation: 0,color: AppColor.appBarColor,
                            child: NewTextFieldWidget(
                                controller: _codeController,
                                iconData: Icons.numbers_sharp,
                                labelText: 'Code',
                                validator: MyValidator.validateAge,
                                keyBoardType: TextInputType.number, dark: false,),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      NewElevatedButtonWidget(
                          onPressed: () {
                            otpVerification(verificationId,_codeController.text,context);

                          },
                          buttonText: 'VERIFY', dark: false,)
                    ],
                  ),
                ),
              );
            },
          );
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          final UserCredential authResult =
              await auth.signInWithCredential(credential);
          User? user = authResult.user;
          if (user != null) {
            navigator.pushReplacement(
                MaterialPageRoute(builder: (_) => const StudentView()));
          } else {
            Fluttertoast.showToast(msg: "ERROR LOGIN WITH PHONE NUMBER");
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Fluttertoast.showToast(msg: "Verification retrieval time out");

        },
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    }
    notifyListeners();
  }

  otpVerification(String token, sms,BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      PhoneAuthCredential credential =
         await PhoneAuthProvider.credential(verificationId: token, smsCode: sms);
      await FirebaseAuth.instance.signInWithCredential(credential);
      navigator.pushReplacementNamed('/home');
      Fluttertoast.showToast(msg: "MOBILE LOGIN SUCCESSFUL");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "OTP VERIFICATION FAILED for ${e.code}");
    }
    notifyListeners();
  }

  signOut(BuildContext context) async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();
    navigator
        .pushReplacement(MaterialPageRoute(builder: (_) => const LoginView()));
  }

  boolChange() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  visibleChange() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
