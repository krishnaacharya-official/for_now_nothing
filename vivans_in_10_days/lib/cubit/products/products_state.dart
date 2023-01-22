part of 'products_cubit.dart';

@immutable
class ProductsState extends Equatable {
  final List<dynamic>? homeCategoryProducts;
  final List<dynamic>? homeSpecialProducts;
  ProductsState copyWith(
      {List<dynamic>? homeCategoryProducts,
      List<dynamic>? homeSpecialProducts}) {
    return ProductsState(
      homeCategoryProducts: homeCategoryProducts ?? this.homeCategoryProducts,
      homeSpecialProducts: homeSpecialProducts ?? this.homeSpecialProducts,
    );
  }

  const ProductsState({this.homeCategoryProducts, this.homeSpecialProducts});
  @override
  List<Object?> get props => [homeCategoryProducts, homeSpecialProducts];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<ProductModel> products;
  const ProductsLoadedState(this.products);
}

class ProductHomeMainLoading extends ProductsState {}

class ProductMainLoaded extends ProductsState {
  const ProductMainLoaded({required List<dynamic> homeMainModel})
      : super(homeCategoryProducts: homeMainModel);
}

class ProductsHomeSpecialLoading extends ProductsState {}

class ProductHomeSpecialLoaded extends ProductsState {
  @override
  final List<HomeProductModel> homeSpecialProducts;
  const ProductHomeSpecialLoaded(this.homeSpecialProducts);
}

class ProductsLoadedHeyState extends ProductsState {
  const ProductsLoadedHeyState({required List<dynamic> homeSpecialModel})
      : super(homeCategoryProducts: homeSpecialModel);
}

class ProductsErrorState extends ProductsState {
  final String error;
  const ProductsErrorState(this.error);
}
