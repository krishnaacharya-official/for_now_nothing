import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vivans_in_10_days/repository/api_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ApiRepository apiRepository = ApiRepository();
  ProductsCubit() : super(ProductsInitial()) {
    init();
  }

  void init() async {
    emit(ProductsLoading(productState: state));
    try {
      var homeCategoryProducts =
          await apiRepository.fetchHomeCategoryProducts();
      var homeSpecialProducts = await apiRepository.fetchHomeSpecialProducts();
      apiRepository.fetchProductsByCategory('Customized');
      emit(state.copyWith(
          homeCategoryProducts: homeCategoryProducts,
          homeSpecialProducts: homeSpecialProducts));
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }

    /**alert: errors should be handled here and accrodingly error message should be put */
  }

  void fetchCategoryProducts(String category) async {
    print("I am inside fetchCategoryProducts");
    emit(ProductsLoading(productState: state));
    try {
      var productsByCategory =
          await apiRepository.fetchProductsByCategory(category);
      emit(state.copyWith(mainCategoryProducts: productsByCategory));
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }
  }

  void fetchCategoryProductsAscDesc(String category, bool asc) async {
    print("I am inside fetchCategoryProductsAscDesc");
    emit(ProductsLoading(productState: state));
    try {
      var productsByCategory =
          await apiRepository.fetchProductsByCategoryAscDesc(category, asc);
      emit(state.copyWith(mainCategoryProducts: productsByCategory));
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }
  }

  void fetchFilteredProducts(List<Map<String, int>> selectedPriceRange,
      List<String> selectedTags) async {
    emit(ProductsLoading(productState: state));
    try {
      var productsByCategory = await apiRepository.fetchFilteredProducts(
          selectedPriceRange, selectedTags);
      emit(state.copyWith(mainCategoryProducts: productsByCategory));
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }
  }

  Future<List?> fetchSimilarForDetailsPage(
      List<String> categories, List<String> tags) async {
    var products =
        await apiRepository.fetchSimilarForDetailsPage(categories, tags);
    return products;
  }
}
