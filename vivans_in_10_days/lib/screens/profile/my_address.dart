// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/users/user_cubit.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/shimmer_address.dart';
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
    super.initState();
    dropdownKey = GlobalKey();
  }

  @override
  void dispose() {
    super.dispose();
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
          if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
            return Column(
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
                      child:
                          "Add New Address".textLargeBold(DesignColor.green)),
                ).marginDown(16),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      AddressModel address = snapshot.data![index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Icon(
                                    size: 28,
                                    Icons.location_on_outlined,
                                    color: DesignColor.purple,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(address.fullName,
                                                maxLines: 1,
                                                style: textStyleLargeBold(
                                                    DesignColor
                                                        .primaryTextColor)),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            /**feature: This can be shown */
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              decoration: BoxDecoration(
                                                color: DesignColor.green
                                                    .withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: address.type
                                                  .textSmall(DesignColor.green),
                                            )
                                          ],
                                        ),
                                        Text(
                                          address.houseNumber,
                                          style: textStyleMediumRegular()
                                              .copyWith(
                                                  color: DesignColor
                                                      .secondaryTextColor),
                                        ),
                                        Text(
                                          address.roadName,
                                          style: textStyleMediumRegular()
                                              .copyWith(
                                                  color: DesignColor
                                                      .secondaryTextColor),
                                        ),
                                        Text(
                                          address.cityName,
                                          style: textStyleMediumRegular()
                                              .copyWith(
                                                  color: DesignColor
                                                      .secondaryTextColor),
                                        )
                                      ],
                                    ).paddingHorizontal(8),
                                  ),
                                  Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            context.pushNamed(Routes.addressAdd,
                                                queryParams: address
                                                    .toJsonString(address.id!));
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: DesignColor.blue,
                                          ),
                                        ).paddingVertical(8),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (dialogContext) {
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
                                                                  dialogContext)
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
                                                                  dialogContext)
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
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: DesignColor.red,
                                          ),
                                        ).paddingVertical(8)
                                      ]),
                                ],
                              ),
                            )).addWidgetColor(Colors.white).marginDown(8),
                      );
                    }),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerAddress();
          }
          return NoDataHelper(
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
