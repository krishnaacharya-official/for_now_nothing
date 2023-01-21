import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/cubit/users/user_state.dart';
import 'package:vivans_in_10_days/models/address_model.dart';
import 'package:vivans_in_10_days/models/user_model.dart';

class UserCubit extends Cubit<UserState> {
  final _firestore = FirebaseFirestore.instance;

  final User? _currentUser = FirebaseAuth.instance.currentUser;

  static List<AddressModel>? appAddressModel;

  UserCubit() : super(UserInitialState()) {
    emit(UserMainLoadingState());
    _firestore
        .collection("users")
        .doc(_currentUser?.uid) // or whatever your collection name is
        .snapshots()
        .listen((event) {
      event.exists
          ? {
              print("User Exists"),
              emit(UserExists(
                  userModel: UserModel.fromjson(event.data()!, event.id)))
            }
          : {print("There is no such user"), emit(UserNotExists())};
    });
  }

  updateUser(
      {String? fullName,
      String? avatar,
      String? email,
      String? phoneNumber,
      String? dob}) {
    emit(state.copyWith(
        name: fullName,
        avatar: avatar,
        dob: dob,
        phoneNumber: phoneNumber,
        email: email));
  }

  Future<void> addUpdateUser({required UserModel userModel}) async {
    emit(UserButtonLoadingState(userModel: state.userModel));
    _firestore
        .collection('users')
        .doc(_currentUser?.uid)
        .set(userModel.toJson())
        .then((value) => emit(UserSavedUpdatedState(userModel: userModel)));
  }

  Future<void> addAddress({required AddressModel address}) async {
    emit(UserButtonLoadingState(userModel: state.userModel));
    _firestore
        .collection('users')
        .doc(_currentUser?.uid)
        .collection('AddressModel')
        .add(address.toJson())
        .catchError((error) {
      emit(UserException(error: error));
    }).then((value) {
      emit(UserAddressSavedUpdated(userModel: state.userModel));
    });
  }

  Future<void> updateAddress(
      {required AddressModel address, required String addressId}) async {
    print("The state inside the updateAddress is ${state.userModel}");
    emit(UserButtonLoadingState(userModel: state.userModel));
    print("The state inside the updateAddress is ${state.userModel}");
    _firestore
        .collection('users')
        .doc(_currentUser?.uid)
        .collection('AddressModel')
        .doc(addressId)
        .set(address.toJson())
        .catchError((error) {
      emit(UserException(error: error, userModel: state.userModel));
    }).then((value) {
      emit(UserAddressSavedUpdated(userModel: state.userModel));
    });
  }

  Future<void> deleteAddress({required String addressId}) async {
    emit(UserButtonLoadingState(userModel: state.userModel));
    _firestore
        .collection('users')
        .doc(_currentUser?.uid)
        .collection('AddressModel')
        .doc(addressId)
        .delete()
        .catchError((error) {
      emit(UserException(error: error, userModel: state.userModel));
    }).then((value) {
      emit(UserAddressSavedUpdated(userModel: state.userModel));
    });
  }

  Stream<List<AddressModel>> getAddress() {
    return _firestore
        .collection('users')
        .doc(_currentUser?.uid)
        .collection('AddressModel')
        .snapshots()
        .map((event) => event.docs
            .map((e) => AddressModel.fromJson(e.data(), e.id))
            .toList());
  }

  Future<void> getme() {
    return _firestore
        .collection('users')
        .doc(_currentUser?.uid)
        .get()
        .then((value) => print(value.data()?['fullName']));
  }
}
