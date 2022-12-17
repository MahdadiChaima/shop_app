import 'package:ap/models/products/productDetailsModel.dart';
import 'package:ap/models/products/productSearchModel.dart';
import '../../../models/favourites/changeFavoritesModel.dart';
import '../../../models/favourites/favoritesModel .dart';

abstract class ShopStates{}
class InitialShop extends ShopStates{}
class ChangeBotNavBarState  extends ShopStates{
  final index;
  ChangeBotNavBarState(this.index);
}
class HomeLoadingState extends ShopStates {}
class HomeSuccessState extends ShopStates {}
class HomeErrorState extends ShopStates {}
//Categories
class CategoriesLoadingState extends ShopStates {}
class CategoriesSuccessState extends ShopStates {}
class CategoriesErrorState extends ShopStates {}
//Category details
class CategoryDetailsLoadingState extends ShopStates {}
class CategoryDetailsSuccessState extends ShopStates {}
class CategoryDetailsErrorState extends ShopStates {}
//change Favorite State
class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}
//Favorites
class FavoritesLoadingState extends ShopStates {}
class DeleteFavoriteItemState extends ShopStates {}
class FavoritesSuccessState extends ShopStates {
  final FavoritesModel favoritesModel;
  FavoritesSuccessState(this.favoritesModel);
}
class FavoritesErrorState extends ShopStates {}




//Product Details
class ProductDetailsLoadingState extends ShopStates {}
class ProductDetailsSuccessState extends ShopStates {
  final ProductDetailsModel productDetailsModel;
  ProductDetailsSuccessState(this.productDetailsModel);
}
class ProductDetailsErrorState extends ShopStates {}
//SearchProduct
class SearchProductLoadingState extends ShopStates {}
class SearchProductSuccessState extends ShopStates {
  final SearchProductModel searchProductModel;
  SearchProductSuccessState(this.searchProductModel);
}
class SearchProductErrorState extends ShopStates {}


//Carts
class CartsLoadingState extends ShopStates {}
class CartsSuccessState extends ShopStates {}
class CartsErrorState extends ShopStates {}

//ChangeCart
class ChangeCartLoadingState extends ShopStates {}
class ChangeCartSuccessState extends ShopStates {}
class ChangeCartErrorState extends ShopStates {}

//UpdateCart
class UpdateCartLoadingState extends ShopStates {}
class UpdateCartSuccessState extends ShopStates {}
class UpdateCartErrorState extends ShopStates {}

//DeleteCart
class DeleteCartLoadingState extends ShopStates {}
class DeleteCartSuccessState extends ShopStates {}
class DeleteCartErrorState extends ShopStates {}










