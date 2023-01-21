// ignore_for_file: slash_for_doc_comments

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/users/user_cubit.dart';
import 'package:vivans_in_10_days/cubit/users/user_state.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/models/user_model.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});
/**alert: If back button is pressed without saving profile 
 * populate a dialog "Discard changes" 
 * */
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

enum Avatar { boy, girl }

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _fullNameKey = GlobalKey<FormState>();
  final _dateOfBirthKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormState>();
  final _mailKey = GlobalKey<FormState>();
  TextEditingController? fullNameController;
  TextEditingController? dateOfBirthController;
  TextEditingController? phoneNumberController;
  TextEditingController? mailAddressController;
  DateTime? selectedDateTime;
  Avatar? selectedAvatar;
  bool _formChecked = false;
  bool _dateChecked = false;
  // AppUser? appUser;
  late UserCubit userCubit;
  late UserState _userState;
  get updateDetails => _userState.userModel != null;

  @override
  void initState() {
    super.initState();

    userCubit = BlocProvider.of<UserCubit>(context);
    _userState = userCubit.state;
    print(
        "I am inside the initState The value of userstate is ${_userState.userModel}");
    fullNameController = TextEditingController();
    dateOfBirthController = TextEditingController();
    phoneNumberController = TextEditingController();
    mailAddressController = TextEditingController();
    phoneNumberController?.text =
        FirebaseAuth.instance.currentUser?.phoneNumber ?? "";
    if (_userState.userModel != null) {
      print("I am building");
      print("user is ${_userState.userModel.toString()}");
      var dateArray = _userState.userModel?.dob.split('/') ?? [];

      selectedAvatar = _userState.userModel?.avatar == "boy"
          ? Avatar.boy
          : _userState.userModel?.avatar == "girl"
              ? Avatar.girl
              : null;
      if (dateArray != [] && dateArray.isNotEmpty) {
        selectedDateTime = DateTime(int.parse(dateArray[2]),
            int.parse(dateArray[1]), int.parse(dateArray[0]));
      }

      dateOfBirthController!.text = _userState.userModel?.dob ?? "";
      mailAddressController!.text = _userState.userModel?.email ?? "";
      phoneNumberController!.text = _userState.userModel?.phoneNumber ?? "";
      fullNameController!.text = _userState.userModel?.fullName ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "My Profile".appBarText(),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.navigate_before)),
        ),
        body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            print("I am inside the listener");
            if (state.userModel != null) {
              print("State is ${state.runtimeType}");

              var dateArray = state.userModel?.dob.split('/') ?? [];

              selectedAvatar = state.userModel?.avatar == "boy"
                  ? Avatar.boy
                  : state.userModel?.avatar == "boy"
                      ? Avatar.girl
                      : null;
              if (dateArray != [] && dateArray.isNotEmpty) {
                selectedDateTime = DateTime(int.parse(dateArray[2]),
                    int.parse(dateArray[1]), int.parse(dateArray[0]));
              }

              dateOfBirthController!.text = state.userModel?.dob ?? "";
              mailAddressController!.text = state.userModel?.email ?? "";
              phoneNumberController!.text = state.userModel?.phoneNumber ?? "";
              fullNameController!.text = state.userModel?.fullName ?? "";
            }
            if (state is UserSavedUpdatedState) {
              context.goNamed(Routes.profileMain);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  backgroundColor: DesignColor.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: updateDetails
                      ? const Text("Details Updated Successfully")
                      : const Text("Details Saved Succesfully"),
                  // content: const Text("Details Save"),
                  duration: const Duration(seconds: 3)));
            }
            if (state is UserException) {
              context.goNamed(Routes.profileMain);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  backgroundColor: DesignColor.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: Text(state.error),
                  duration: const Duration(seconds: 3)));
            }
          },
          child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedAvatar = Avatar.boy;
                            });
                          },
                          child: Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                                border: selectedAvatar == Avatar.boy
                                    ? Border.all(
                                        color: DesignColor.orange,
                                        width: 5,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside)
                                    : Border.all(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(50),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/avatars/boy.png'))),
                          ),
                        ),
                        "OR".textMediumRegular().paddingHorizontal(8),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedAvatar = Avatar.girl;
                            });
                            // state.appUser?.avatar = "girl";
                          },
                          child: Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                                border: selectedAvatar == Avatar.girl
                                    ? Border.all(
                                        color: DesignColor.orange,
                                        width: 5,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside)
                                    : Border.all(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(50),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/avatars/girl.png'))),
                          ),
                        ),
                      ],
                    ).marginDown(32),
                    Form(
                      key: _fullNameKey,
                      child: TextFormField(
                        autovalidateMode: _formChecked
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (value) {
                          if (value == null ||
                              fullNameController?.text.trim() == "") {
                            return "Name cannot be empty";
                          }
                          if (value.length < 3) {
                            return "Username must be greater than 3 characters";
                          }
                          return null;
                        },
                        controller: fullNameController,
                        decoration: const InputDecoration(
                          labelText: "Full Name",
                        ),
                      ).marginDown(16),
                    ),
                    Form(
                      key: _dateOfBirthKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              dateOfBirthController?.text.trim() == "") {
                            return "Date of birth cannot be empty";
                          }

                          if (selectedDateTime != null &&
                              selectedDateTime!
                                      .difference(DateTime.now())
                                      .inHours >
                                  0) {
                            return 'Invalid Date';
                          }
                          return null;
                        },
                        autovalidateMode: (_dateChecked || _formChecked)
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        controller: dateOfBirthController,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());

                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: selectedDateTime ??
                                  DateTime.now()
                                      .subtract(const Duration(days: 365)),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());

                          setState(() {
                            selectedDateTime = date;
                            _dateChecked = true;
                          });
                          if (selectedDateTime != null) {
                            dateOfBirthController?.text =
                                "${selectedDateTime?.day}/${selectedDateTime?.month}/${selectedDateTime?.year}";
                          }
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today_rounded),
                          labelText: "Date of Birth",
                        ),
                        keyboardType: TextInputType.datetime,
                      ).marginDown(),
                    ),
                    Form(
                      key: _phoneKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              phoneNumberController?.text.trim() == "") {
                            return "Phone number cannot be empty";
                          }
                          if (value.length < 10 || value.length > 13) {
                            return "Invalid Phone Number";
                          }
                          return null;
                        },
                        autovalidateMode: _formChecked
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration:
                            const InputDecoration(labelText: "Phone Number"),
                      ).marginDown(),
                    ),
                    Form(
                      key: _mailKey,
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Email Address"),
                        keyboardType: TextInputType.emailAddress,
                        controller: mailAddressController,
                        autovalidateMode: _formChecked
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (value) {
                          if (value == null ||
                              mailAddressController?.text.trim() == "") {
                            return "Email address cannot be empty";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'Invalid Email Address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              )).paddingAll(16),
        ),
        bottomNavigationBar: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserButtonLoadingState) {
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
                        "Loading".textLargeBold(DesignColor.disabledTextColor),
                        // "Generate OTP".textLargeBold()
                      ])).paddingHorizontal(16).marginDown(16);
            }

            return FilledButton(
                    onPressed: () {
                      print("selectedAvatar $selectedAvatar");
                      if (selectedAvatar == null) {
                        /**alert: see this if this works even initially when the user is not in the database  */
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          backgroundColor: DesignColor.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          content: const Text("Please select avatar"),
                          duration: const Duration(seconds: 3),
                        ));
                      }
                      if (_fullNameKey.currentState!.validate() &&
                          _dateOfBirthKey.currentState!.validate() &&
                          _phoneKey.currentState!.validate() &&
                          _mailKey.currentState!.validate() &&
                          selectedAvatar != null) {
                        print(
                            "Inside the button press of the my profile screen");

                        UserModel userModel = UserModel(
                            avatar:
                                selectedAvatar == Avatar.boy ? "boy" : "girl",
                            dob: dateOfBirthController!.text,
                            email: mailAddressController!.text,
                            fullName: fullNameController!.text,
                            phoneNumber: phoneNumberController!.text);
                        // BlocProvider.of<UserCubit>(context).updateUser(
                        //     fullName: fullNameController!.text,
                        //     avatar: state.userModel!.avatar,
                        //     dob: dateOfBirthController!.text,
                        //     email: mailAddressController!.text,
                        //     phoneNumber: phoneNumberController!.text);
                        BlocProvider.of<UserCubit>(context)
                            .addUpdateUser(userModel: userModel);
                      }

                      setState(() {
                        _formChecked = true;
                      });
                    },
                    child: updateDetails
                        ? "Update Profile".textLargeBold(DesignColor.white)
                        : "Save Profile".textLargeBold(DesignColor.white))
                // child: "Save Profile".textLargeBold())
                .paddingHorizontal(16)
                .marginDown(16);
          },
        ));
  }
}
