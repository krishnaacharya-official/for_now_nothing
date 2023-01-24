part of 'products_cubit.dart';

@immutable
class ProductsState extends Equatable {
  final List<dynamic>? homeCategoryProducts;
  final List<dynamic>? homeSpecialProducts;
  final List<dynamic>? mainCategoryProducts;
  ProductsState copyWith(
      {List<dynamic>? homeCategoryProducts,
      List<dynamic>? homeSpecialProducts,
      List<dynamic>? mainCategoryProducts}) {
    return ProductsState(
      mainCategoryProducts: mainCategoryProducts ?? this.mainCategoryProducts,
      homeCategoryProducts: homeCategoryProducts ?? this.homeCategoryProducts,
      homeSpecialProducts: homeSpecialProducts ?? this.homeSpecialProducts,
    );
  }

  // ProductsState(ProductsState productsState){
  //   return productsState;
  // }
  const ProductsState(
      {this.homeCategoryProducts,
      this.homeSpecialProducts,
      this.mainCategoryProducts});
  @override
  List<Object?> get props => [homeCategoryProducts, homeSpecialProducts];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {
  final ProductsState productState;
  ProductsLoading({required this.productState})
      : super(
            homeCategoryProducts: productState.homeCategoryProducts,
            homeSpecialProducts: productState.homeSpecialProducts,
            mainCategoryProducts: productState.mainCategoryProducts);
}

class ProductsByCategoryLoaded extends ProductsState {
  final List<dynamic> productModel;
  ProductsByCategoryLoaded({required this.productModel}) {
    print(
        "The product model from inside the ProductsByCategoryLoaded is : $productModel");
  }
}

// class ProductsLoadedState extends ProductsState {
//   final List<ProductModel> products;
//   const ProductsLoadedState(this.products);
// }

// class ProductHomeMainLoading extends ProductsState {}

// class ProductMainLoaded extends ProductsState {
//   const ProductMainLoaded({required List<dynamic> homeMainModel})
//       : super(homeCategoryProducts: homeMainModel);
// }

// class ProductsHomeSpecialLoading extends ProductsState {}

// class ProductHomeSpecialLoaded extends ProductsState {
//   @override
//   final List<HomeProductModel> homeSpecialProducts;
//   const ProductHomeSpecialLoaded(this.homeSpecialProducts);
// }

// class ProductsLoadedHeyState extends ProductsState {
//   const ProductsLoadedHeyState({required List<dynamic> homeSpecialModel})
//       : super(homeCategoryProducts: homeSpecialModel);
// }

class ProductsErrorState extends ProductsState {
  final String error;
  const ProductsErrorState(this.error);
}
