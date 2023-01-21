// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_cubit.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_state.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

/**alert: When you go out from the app in the middle of phone authentication , it directly opens to homeScreen */
/**alert: E/FirebaseAuth( 5764): [SmsRetrieverHelper] SMS verification code request failed: unknown status code: 17010 nulls */
/**alert E/zzf     (13461): Problem retrieving SafetyNet Token: 16 */
/**alert Captcha not selected */
class SignIn extends StatefulWidget {
  String? number;
  SignIn({super.key, this.number});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();
  bool pressed = false;
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  late FocusNode myFocusNode;
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  @override
  void dispose() {
    _controller.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
    _controller = TextEditingController();
    if (widget.number != null) _controller.text = widget.number!;
    super.initState();
    animation = AnimationController(
        upperBound: 100,
        lowerBound: 0,
        vsync: this,
        duration: const Duration(seconds: 3),
        animationBehavior: AnimationBehavior.preserve);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in "),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TextStyleTitleMedium("Enter your Phone Number to continue")
                  .marginTop(16),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const TextStyleTitleMedium("+91").marginRight(8),
                    Expanded(
                        child: Form(
                      key: _formKey,
                      child: TextFormField(
                        focusNode: myFocusNode,
                        autofocus: true,
                        controller: _controller,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                        ),
                        // validate after each user interaction
                        autovalidateMode: _submitted
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        // The validator receives the text that the user has entered.
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (text.length < 10 || text.length > 10) {
                            return 'Invalid Phone Number';
                          }
                          return null;
                        },
                      ).paddingHorizontal(8),
                    )),
                  ]).marginTop(32),
              const Spacer(),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthCodeSentState) {
                    context.goNamed(Routes.otpScreen,
                        params: {'id': _controller.text});
                  } else if (state is AuthErrorState) {
                    /**feature: Improve this  */
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(16),
                      backgroundColor: DesignColor.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      content: Text(state.error),
                      duration: const Duration(seconds: 3),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return FilledButton(
                        onPressed: null,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: DesignColor.green.withOpacity(0.6),
                                  )).marginRight(16),
                              "Loading"
                                  .textLargeBold(DesignColor.disabledTextColor),
                              // "Generate OTP".textLargeBold()
                            ]));
                  }
                  return FilledButton(
                      onPressed: () {
                        setState(() {
                          _submitted = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          // print("I am inside this ${_controller.text}");

                          String phoneNumber = "+91${_controller.text}";
                          BlocProvider.of<AuthCubit>(context)
                              .sendOTP(phoneNumber);
                        }
                      },
                      child: ("Generate OTP".textLargeBold(DesignColor.white)));
                },
              ),
            ],
          ).paddingAll(16),
        ],
      ),
    );
  }
}
