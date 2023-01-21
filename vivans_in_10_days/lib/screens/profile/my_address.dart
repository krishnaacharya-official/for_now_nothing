// ignore_for_file: slash_for_doc_comments

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/users/user_cubit.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/models/address_model.dart';
import 'package:vivans_in_10_days/screens/miscellenous/miscillenous.dart';

/**alert: Check every pages Elipsis feature it should not overflow */
/**alert: Check max lines and elipsis overflow for alomost every text */
class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  late GlobalKey dropdownKey;
  final List<String> items = ['Edit', "Delete"];
  String selectedValue = 'Edit';

  @override
  void initState() {
    dropdownKey = GlobalKey();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColor.grey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.navigate_before,
          ),
        ),
        title: "My Address".appBarText(),
      ),
      body: StreamBuilder(
        stream: BlocProvider.of<UserCubit>(context).getAddress(),
        builder: (context, AsyncSnapshot<List<AddressModel>> snapshot) {
          if (snapshot.hasError) {
            return NoDataHelper(
                iconData: Icons.location_off_outlined,
                title: "No Address",
                buttonTitle: "Add Address",
                buttonType: ButtonType.filled,
                onTap: () => {context.pushNamed(Routes.addressAdd)});
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.isNotEmpty
              ? Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: DesignColor.white,
                              side: BorderSide(color: DesignColor.green)),
                          onPressed: () {
                            context.pushNamed(Routes.addressAdd);
                          },
                          child: "Add New Address"
                              .textLargeBold(DesignColor.green)),
                    ).marginDown(16),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          AddressModel address = snapshot.data![index];

                          return ListTile(
                            onTap: () {
                              print(
                                  "Inside the fucking ontap, address id is ${address.id}");
                              // context.pushNamed(
                              //   Routes.addressAdd,
                              //   queryParams: address.toJsonString(address.id!),
                              // );
                            },
                            contentPadding:
                                const EdgeInsets.only(left: 8, right: 8),
                            tileColor: DesignColor.white,
                            horizontalTitleGap: 8,
                            minLeadingWidth: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            leading: Icon(
                              size: 28,
                              Icons.location_on_outlined,
                              color: DesignColor.purple,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    address.fullName,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: DesignColor.green.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:
                                      address.type.textSmall(DesignColor.green),
                                )
                              ],
                            ),
                            subtitle:
                                ("${address.houseNumber}, ${address.roadName}, ${address.cityName}")
                                    .textSmall(),
                            trailing: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                key: dropdownKey,
                                customButton: const Icon(
                                  Icons.more_vert_rounded,
                                  // size: 46,
                                  // color: Colors.red,
                                ),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: InkWell(
                                            onTap: () {
                                              if (item == "Edit") {
                                                // myFocusNode.unfocus();
                                                Navigator.pop(dropdownKey
                                                    .currentContext!);
                                                context.pushNamed(
                                                    Routes.addressAdd,
                                                    queryParams:
                                                        address.toJsonString(
                                                            address.id!));
                                              } else {
                                                Navigator.pop(dropdownKey
                                                    .currentContext!);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Remove Address'), // To display the title it is optional
                                                        content: const Text(
                                                            'Are you sure you want to delete this address?'), // Message which will be pop up on the screen
                                                        // Action widget which will provide the user to acknowledge the choice
                                                        actions: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Container(
                                                                    child: "Cancel"
                                                                        .textLargeRegular())
                                                                .marginRight(),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();

                                                              BlocProvider.of<
                                                                          UserCubit>(
                                                                      context)
                                                                  .deleteAddress(
                                                                      addressId:
                                                                          address
                                                                              .id!);
                                                            },
                                                            child: Container(

                                                                // decoration: ,
                                                                child: "Confirm"
                                                                    .textLargeRegular(
                                                                        DesignColor
                                                                            .red)),
                                                          )
                                                        ],
                                                      );
                                                    });
                                              }
                                            },
                                            child: Text(
                                              item,
                                              style: textStyleSmall(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as String;
                                  });
                                },
                                dropdownDecoration:
                                    BoxDecoration(color: DesignColor.white),
                                // itemHeight: 48,
                                // itemPadding:
                                //     const EdgeInsets.only(left: 16, right: 16),
                                dropdownWidth: 80,
                                dropdownElevation: 8,
                                offset: const Offset(0, 8),
                              ),
                            ),
                          ).marginDown(8);
                        }),
                  ],
                )
              : NoDataHelper(
                  iconData: Icons.location_off_outlined,
                  title: "No Address",
                  buttonTitle: "Add Address",
                  buttonType: ButtonType.filled,
                  onTap: () => {context.pushNamed(Routes.addressAdd)});
        },
      ).paddingAll(16),
    );
  }
}
