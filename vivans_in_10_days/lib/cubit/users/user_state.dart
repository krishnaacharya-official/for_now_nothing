import 'package:vivans_in_10_days/models/user_model.dart';

class UserState {
  final UserModel? userModel;
  const UserState({this.userModel});
  UserState copyModel({required UserModel userModel}) {
    return UserState(userModel: userModel);
  }

  UserState copyWith(
      {String? name,
      String? avatar,
      String? dob,
      String? email,
      String? phoneNumber}) {
    return UserState(
        userModel: UserModel(
            email: email ?? userModel?.email ?? "",
            phoneNumber: phoneNumber ?? userModel?.phoneNumber ?? "",
            dob: dob ?? userModel?.dob ?? "",
            fullName: name ?? userModel?.fullName ?? "",
            avatar: avatar ?? userModel?.avatar ?? ""));
  }

  // @override
  // List<Object?> get props => [userModel];
}

class UserInitialState extends UserState {}

class UserMainLoadingState extends UserState {}

class UserButtonLoadingState extends UserState {}

class UserSavedUpdatedState extends UserState {
  const UserSavedUpdatedState({required UserModel userModel})
      : super(userModel: userModel);
}

class UserExists extends UserState {
  UserExists({required UserModel userModel}) : super(userModel: userModel) {
    print("I am inside the UserExists state and the user is :$userModel");
    // UserState userState = const UserState();
    // userState.copyWith(
    //     email: userModel.email,
    //     phoneNumber: userModel.phoneNumber,
    //     dob: userModel.dob,
    //     name: userModel.fullName,
    //     avatar: userModel.avatar);
  }
}

class UserNotExists extends UserState {}
// class UserExistsState extends UserState{}

class UserAddressSaved extends UserState {}

class UserAddressUpdated extends UserState {}

// class UserExists extends UserState {
//   const UserExists({required AppUser user}) : super(appUser: user);
// }

// class UserExists extends UserState {
//   AppUser user;
//   UserExists({required this.user});
// }

class UserException extends UserState {
  String error;
  UserException({required this.error});
}
