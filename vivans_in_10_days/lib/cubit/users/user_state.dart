import 'package:vivans_in_10_days/models/user_model.dart';

class UserState {
  final UserModel? userModel;
  const UserState({this.userModel});
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

class UserButtonLoadingState extends UserState {
  const UserButtonLoadingState({UserModel? userModel})
      : super(userModel: userModel);
}

class UserSavedUpdatedState extends UserState {
  const UserSavedUpdatedState({UserModel? userModel})
      : super(userModel: userModel);
}

class UserExists extends UserState {
  UserExists({required UserModel userModel}) : super(userModel: userModel) {
    print("I am inside the UserExists state and the user is :$userModel");
  }
}

class UserNotExists extends UserState {}

class UserAddressSavedUpdated extends UserState {
  UserAddressSavedUpdated({UserModel? userModel}) : super(userModel: userModel);
}

class UserException extends UserState {
  String error;
  @override
  UserModel? userModel;
  UserException({required this.error, this.userModel})
      : super(userModel: userModel);
}
