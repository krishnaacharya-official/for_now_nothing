// import 'package:vivans_in_10_days/app_routes.dart';
// import 'package:vivans_in_10_days/bloc/auth/auth_cubit.dart';
// import 'package:vivans_in_10_days/bloc/auth/auth_state.dart';
// import 'package:vivans_in_10_days/data/models/user_address.dart';
// import 'package:vivans_in_10_days/screens/home/cart_screen.dart';
// import 'package:vivans_in_10_days/screens/home/details_screen.dart';
// import 'package:vivans_in_10_days/screens/home/home.dart';
// import 'package:vivans_in_10_days/screens/home/main_home.dart';
// import 'package:vivans_in_10_days/screens/phoneAuth/otp_screen.dart';
// import 'package:vivans_in_10_days/screens/phoneAuth/sign_in.dart';
// import 'package:vivans_in_10_days/screens/profile/add_address.dart';
// import 'package:vivans_in_10_days/screens/profile/my_address.dart';
// import 'package:vivans_in_10_days/screens/profile/my_profile.dart';
// import 'package:vivans_in_10_days/screens/profile/profile_%20main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_cubit.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_state.dart';
import 'package:vivans_in_10_days/helpers/constants.dart';
import 'package:vivans_in_10_days/models/address_model.dart';
import 'package:vivans_in_10_days/models/products_main_model.dart';
import 'package:vivans_in_10_days/sample.dart';
import 'package:vivans_in_10_days/screens/home/bottom_navigation_home.dart';
import 'package:vivans_in_10_days/screens/home/cart_screen.dart';
import 'package:vivans_in_10_days/screens/home/categories_all.dart';
import 'package:vivans_in_10_days/screens/home/categories_screen.dart';
import 'package:vivans_in_10_days/screens/home/details_screen.dart';
import 'package:vivans_in_10_days/screens/home/filter_screen.dart';
import 'package:vivans_in_10_days/screens/home/home.dart';
import 'package:vivans_in_10_days/screens/home/home_product_list.dart';
import 'package:vivans_in_10_days/screens/home/special_offers_all.dart';
import 'package:vivans_in_10_days/screens/phoneAuth/otp_screen.dart';
import 'package:vivans_in_10_days/screens/phoneAuth/sign_in.dart';
import 'package:vivans_in_10_days/screens/profile/add_address.dart';
import 'package:vivans_in_10_days/screens/profile/my_address.dart';
import 'package:vivans_in_10_days/screens/profile/my_profile.dart';
import 'package:vivans_in_10_days/screens/profile/profile_%20main.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: "/",
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (oldState, newState) {
          return oldState is AuthInitialState;
        }, builder: (context, state) {
          if (state is AuthLoggedInState) {
            // return const MainHomeScreen();

            return const MyWidget();
          } else {
            return SignIn();
          }
        });
      }),
  GoRoute(
      path: '/homeMain',
      name: Routes.homeMain,
      builder: (context, state) => const MainHomeScreen()),
  GoRoute(
      name: Routes.home,
      path: '/home',
      builder: (context, state) => const Home()),
  GoRoute(
      name: Routes.details,
      path: '/details',
      builder: (context, state) => DetailsScreen(
            sample: state.queryParams[0]!,
          )),
  GoRoute(
      path: '/otpScreen/:id',
      name: Routes.otpScreen,
      builder: (context, state) => OtpScreen(number: state.params['id']!)),
  GoRoute(
      path: '/cart',
      name: Routes.cart,
      builder: (context, state) => CartScreen()),
  GoRoute(
      name: Routes.signIn,
      path: '/signIn',
      builder: (context, state) => SignIn(number: state.queryParams['number'])),
  GoRoute(
      path: '/profile',
      name: Routes.profileMain,
      builder: (context, state) => const ProfileScreen()),
  GoRoute(
      path: '/profileMine',
      name: Routes.profileMine,
      builder: (context, state) => const MyProfileScreen()),
  GoRoute(
      path: '/address',
      name: Routes.addressMine,
      builder: (context, state) => const MyAddress()),
  GoRoute(
      path: '/addAddress',
      name: Routes.addressAdd,
      builder: (context, state) => state.queryParams.isNotEmpty
          ? AddAddress(address: AddressModel.fromJsonString(state.queryParams))
          : AddAddress()),
  GoRoute(
    path: '/specialOffer',
    name: Routes.specialOffer,
    builder: (context, state) {
      List<dynamic> homeSpecialProducts = state.extra as List<dynamic>;
      return SpecialOffersScreen(homeSpecialProducts: homeSpecialProducts);
    },
  ),
  GoRoute(
    path: '/homeProductList',
    name: Routes.homeProductList,
    builder: (context, state) {
      bool showSortFilter = state.queryParams['showSortFilter'] != null
          ? state.queryParams['showSortFilter'] == "true"
          : false;
      String? appBarTitle = state.queryParams['appBarTitle'];

      HomeProductModel homeProductModel = state.extra as HomeProductModel;
      return HomeProductsList(
          homeProductModel: homeProductModel,
          appBarTitle: appBarTitle,
          showSortFilter: showSortFilter);
    },
  ),
  GoRoute(
      path: '/categoryAll',
      name: Routes.categoryAll,
      builder: (context, state) {
        return const CategoriesAll();
      }),
  GoRoute(
      path: '/category',
      name: Routes.category,
      builder: (context, state) {
        String? title = state.queryParams['name'];
        CategoryList category = state.extra as CategoryList;
        return CategoriesScreen(category: category, title: title);
      }),
  GoRoute(
    path: '/filter',
    name: Routes.filter,
    builder: (context, state) => const FilterScreen(),
  )
  // GoRoute(path: '/detailedCategory')
]);
