// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/cubit/users/user_cubit.dart';
import 'package:vivans_in_10_days/cubit/users/user_state.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/models/address_model.dart';

/**alert: edit click doesn't every time open for the first time, it opens randomly at nth click */
/**alert: when default address is selected make sure the other address are removed from default
 Only one default should be at a time.
 For now in the my_address screen the chip will contain only the home/office once
this is taken care of default will be added in chip. */
class AddAddress extends StatefulWidget {
  AddressModel? address;
  AddAddress({super.key, this.address});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _fullNameKey = GlobalKey<FormState>();
  final _phoneNumberKey = GlobalKey<FormState>();
  final _houseNumberKey = GlobalKey<FormState>();
  final _roadNameKey = GlobalKey<FormState>();
  final _cityNameKey = GlobalKey<FormState>();

  TextEditingController? fullNameController;
  TextEditingController? phoneNumberController;
  TextEditingController? houseNumberController;
  TextEditingController? roadNameController;
  TextEditingController? cityNameController;
  bool _formChecked = false;
  bool isDefault = false;

  List<bool> _isSelected = [true, false];
  bool get editMode => widget.address != null;
  late UserCubit userCubit;
  late UserState _userState;
  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      print("Address is ${widget.address?.id}");
    }

    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    houseNumberController = TextEditingController();
    roadNameController = TextEditingController();
    cityNameController = TextEditingController();
    // userCubit = BlocProvider.of<UserCubit>(context);
    // _userState = userCubit.state;
    // phoneNumberController?.text =
    //     FirebaseAuth.instance.currentUser?.phoneNumber ??
    //         _userState.userModel?.phoneNumber ??
    //         '';
    // fullNameController?.text = _userState.userModel?.fullName ?? "";

    fullNameController!.text = editMode ? widget.address!.fullName : "";
    phoneNumberController!.text = editMode ? widget.address!.phoneNumber : "";
    houseNumberController!.text = editMode ? widget.address!.houseNumber : "";
    roadNameController!.text = editMode ? widget.address!.roadName : "";
    cityNameController!.text = editMode ? widget.address!.cityName : "";
    isDefault = editMode ? widget.address!.isDefault == true : false;
    if (widget.address != null) {
      widget.address!.type == "home"
          ? _isSelected = [true, false]
          : _isSelected = [false, true];
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "Add New Address".appBarText(),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.navigate_before)),
        ),
        body: BlocConsumer<UserCubit, UserState>(listener: (context, state) {
          if (state is UserAddressSaved) {
            // context.goNamed(Routes.addressMine);
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                backgroundColor: DesignColor.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: const Text("Address Saved Succesfully"),
                duration: const Duration(seconds: 3)));
          }
          if (state is UserAddressUpdated) {
            // context.goNamed(Routes.addressMine);
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                backgroundColor: DesignColor.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: const Text("Address Updated Succesfully"),
                duration: const Duration(seconds: 3)));
          }
        }, builder: (context, state) {
          if (state is UserMainLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _fullNameKey,
                child: TextFormField(
                  controller: fullNameController,
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
                  decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: textStyleMediumRegular()),
                ).marginDown(),
              ),
              Form(
                key: _phoneNumberKey,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneNumberController,
                  autovalidateMode: _formChecked
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  validator: (value) {
                    if (value == null ||
                        phoneNumberController?.text.trim() == "") {
                      return "Phone Number cannot be empty";
                    }
                    if (value.length < 10 || value.length > 13) {
                      return "Invalid Phone Number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Phone Number"),
                ).marginDown(),
              ),
              Form(
                key: _houseNumberKey,
                child: TextFormField(
                  controller: houseNumberController,
                  autovalidateMode: _formChecked
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  validator: (value) {
                    if (value == null ||
                        houseNumberController?.text.trim() == "") {
                      return "This field cannot be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "House Name, Building Number"),
                ).marginDown(),
              ),
              Form(
                key: _roadNameKey,
                child: TextFormField(
                  controller: roadNameController,
                  autovalidateMode: _formChecked
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  validator: (value) {
                    if (value == null ||
                        roadNameController?.text.trim() == "") {
                      return "This field cannot be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Road Name, Area, Colony"),
                ).marginDown(),
              ),
              Form(
                key: _cityNameKey,
                child: TextFormField(
                  controller: cityNameController,
                  autovalidateMode: _formChecked
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  validator: (value) {
                    if (value == null ||
                        cityNameController?.text.trim() == "") {
                      return "This field cannot be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "City"),
                ).marginDown(),
              ),
              ToggleButtons(
                  textStyle: textStyleMediumBold(),
                  isSelected: _isSelected,
                  borderColor: DesignColor.green,
                  borderRadius: BorderRadius.circular(4),
                  borderWidth: 2,
                  selectedBorderColor: DesignColor.green,
                  selectedColor: DesignColor.white,
                  fillColor: DesignColor.green,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _isSelected.length; i++) {
                        _isSelected[i] = i == index;
                      }
                    });
                  },
                  children: [
                    const Text("Home").paddingAll(8),
                    const Text("Office").paddingAll(8)
                  ]),
              CheckboxListTile(
                value: isDefault,
                onChanged: (value) {
                  setState(() {
                    isDefault = value!;
                  });
                },
                title: "Use as default delivery address".textMediumRegular(),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              )
            ],
          )).paddingAll(16);
        }),
        bottomNavigationBar:
            BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (state is UserButtonLoadingState) {
            return FilledButton(
                onPressed: null,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              if (_fullNameKey.currentState!.validate() &&
                  _phoneNumberKey.currentState!.validate() &&
                  _cityNameKey.currentState!.validate() &&
                  _houseNumberKey.currentState!.validate() &&
                  _roadNameKey.currentState!.validate()) {
                print("Helllllllllllllllllllloo");
                // Here create the model and add

                AddressModel address = AddressModel(
                    type: _isSelected[0] == true ? "home" : "office",
                    fullName: fullNameController!.text,
                    phoneNumber: phoneNumberController!.text,
                    houseNumber: houseNumberController!.text,
                    roadName: roadNameController!.text,
                    cityName: cityNameController!.text,
                    isDefault: isDefault);

                editMode
                    ? BlocProvider.of<UserCubit>(context).updateAddress(
                        address: address, addressId: widget.address!.id!)
                    : BlocProvider.of<UserCubit>(context)
                        .addAddress(address: address);
              }
              setState(() {
                _formChecked = true;
              });
            },
            child: editMode
                ? "Update Address".textLargeBold(DesignColor.white)
                : "Save Address".textLargeBold(DesignColor.white),
          ).paddingAll(16);
        }));
  }
}
