import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_cubit.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_state.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class OtpScreen extends StatefulWidget {
  String number;
  OtpScreen({super.key, required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  AnimationController? _controller;
  int levelClock = 10;
  late TextEditingController textEditingController;

  String currentText = "";
  bool timeFinished = false;
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 30);

  String strDigits(int n) => "00:${n.toString().padLeft(2, '0')}";
  setTimeFinished() {
    if (mounted) {
      setState(() {
        timeFinished = true;
      });
    }
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    if (!mounted) return;
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    if (!mounted) return;
    setState(() => myDuration = const Duration(seconds: 30));
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    if (!mounted) return;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();

    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Phone")),
      body: Container(
        color: DesignColor.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                      text: 'Enter the verification code we\'ve sent you on ',
                      style: Theme.of(context).textTheme.titleMedium),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text(
                      "+91-${widget.number}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.goNamed(Routes.signIn,
                              queryParams: {'number': widget.number});
                        },
                      text: "  Edit",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: DesignColor.blue))
                ],
              ),
            ).marginTop(16),
            PinCodeTextField(
              keyboardType: TextInputType.number,
              autoFocus: true,
              controller: textEditingController,
              autoDismissKeyboard: false,
              pastedTextStyle: textStyleMediumBold(DesignColor.black),
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                activeColor: DesignColor.green,
                selectedColor: DesignColor.green,
                inactiveColor: DesignColor.black,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                borderWidth: 1,
                fieldHeight: 50,
                activeFillColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              // backgroundColor: Colors.blue.shade50,
              // enableActiveFill: true,
              onCompleted: (v) {
                debugPrint("Completed");
                BlocProvider.of<AuthCubit>(context).verifyOTP(currentText);
              },
              onChanged: (value) {
                debugPrint(value);
                if (mounted) {
                  setState(() {
                    currentText = value;
                  });
                }
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: context,
            ).marginTop(32).marginLeftRight(8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: DesignColor.blue,
                      strokeWidth: 2,
                    ),
                  ),
                  const TextStyleLabelMedium("Auto Capturing").marginLeft(8)
                ],
              ),
              myDuration.inSeconds != 0
                  ? Text(seconds)
                  : InkWell(
                      onTap: () {
                        resetTimer();
                        startTimer();
                        setState(() {
                          textEditingController.clear();
                          currentText = "";
                          debugPrint(
                              "Inside resend current text: $currentText ");
                        });
                        BlocProvider.of<AuthCubit>(context)
                            .sendOTP("+91${widget.number}");
                      },
                      child: Text(
                        "Resend",
                        style: TextStyle(color: DesignColor.purple),
                      ),
                    )
            ]).marginLeftRight(8),
            const Spacer(),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedInState) {
                  /**feature: Improve this by providing the otp to the pinfield during auto verfication */

                  context.goNamed(Routes.homeMain);
                } else if (state is AuthErrorState) {
                  /**feature: Improve this  */
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(16),
                    backgroundColor: DesignColor.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: Text(
                      state.error,
                    ),
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
                      print("Otp verification code is $currentText");
                      BlocProvider.of<AuthCubit>(context)
                          .verifyOTP(currentText);
                    },
                    style: FilledButton.styleFrom(
                      foregroundColor: DesignColor.white,
                    ),
                    child: "Verify Phone".textLargeBold(DesignColor.white));
              },
            ),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
