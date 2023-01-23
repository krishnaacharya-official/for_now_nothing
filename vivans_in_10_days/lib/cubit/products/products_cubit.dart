import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vivans_in_10_days/models/product_model.dart';
import 'package:vivans_in_10_days/models/products_main_model.dart';
import 'package:vivans_in_10_days/repository/api_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ApiRepository apiRepository = ApiRepository();
  ProductsCubit() : super(ProductsInitial()) {
    init();
  }

  void init() async {
    emit(ProductsLoading());
    try {
      var homeCategoryProducts =
          await apiRepository.fetchHomeCategoryProducts();
      var homeSpecialProducts = await apiRepository.fetchHomeSpecialProducts();
      emit(state.copyWith(
          homeCategoryProducts: homeCategoryProducts,
          homeSpecialProducts: homeSpecialProducts));
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }

    /**alert: errors should be handled here and accrodingly error message should be put */
  }

  void fetchProducts() async {
    ProductsLoading();
    try {
      var products = await apiRepository.fetchProducts();
      emit(ProductsLoadedHeyState(homeSpecialModel: products));
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }
  }

  // void fetchHomeMainProducts() async {
  //   emit(ProductHomeMainLoading());
  //   var productMain = await apiRepository.getHomeMain();
  //   emit(ProductMainLoaded(homeMainModel: productMain));
  // }

  // void fetchHomeSpecialProducts() async {
  //   emit(ProductsHomeSpecialLoading());
  //   var productMain = await apiRepository.getHomeSpecial();
  //   emit(ProductHomeSpecialLoaded(productMain));
  // }
}
