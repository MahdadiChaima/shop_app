
import 'package:ap/layout/Shop/Cubit/states.dart';
import 'package:ap/models/home/ShopHomeModel.dart';
import 'package:ap/models/carts/cartsModel.dart';
import 'package:ap/models/categories/categoryDetailsModel.dart';
import 'package:ap/models/carts/changeCartModel.dart';
import 'package:ap/models/favourites/changeFavoritesModel.dart';
import 'package:ap/models/products/productDetailsModel.dart';
import 'package:ap/models/products/productSearchModel.dart';
import 'package:ap/models/carts/updateCartModel.dart';
import 'package:ap/modules/categories/categoriesScreen.dart';
import 'package:ap/modules/favorite/favoriteScreen.dart';
import 'package:ap/modules/products/productsScreen.dart';
import 'package:ap/modules/settings/settingsScreen.dart';
import 'package:ap/shared/network/dioHelper.dart';
import 'package:ap/shared/network/endPoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/categories/categoriesModel.dart';
import '../../../models/favourites/favoritesModel .dart';
import '../../../shared/components/constants.dart';
class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(InitialShop());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int indexNavBar=0;
  Widget widget=const ProductsScreen();
  List<Widget> widgets=[
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    const SettingsScreen()
  ];
  List<String> appBarTitle=["Products","Categories","Favorites","Settings"];

  ShopHomeModel? shopHomeModel;
  void changeBottomBar(index){
    indexNavBar=index;
    widget=widgets[index];
    emit(ChangeBotNavBarState(indexNavBar));
  }
  void getHomeData(){
    emit(HomeLoadingState());
    DioHelper.getData(path: shopHomePath,token: token).then((value){
      shopHomeModel=ShopHomeModel.toObject(value.data);
      shopHomeModel=shopHomeModel;
      shopHomeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!:element.inFav!
        }
        );
        products.add(element);});
      shopHomeModel!.data!.banners.forEach((element) {
        if(element.id==11||element.id==25) {banners.add(element);}});
      print(shopHomeModel!.status);
      emit(HomeSuccessState());
    }).catchError((onError){print("ERROR :${onError.toString()}");
    emit(HomeErrorState());});
  }


  /***********Categories**************/


   CategoriesModel? categoriesModel;
  void getCategories(){
    emit(CategoriesLoadingState());
    DioHelper.getData(path: getCategoriesPath).then((value) {
      categoriesModel=CategoriesModel.toObject(value.data);

      emit(CategoriesSuccessState());
    }
    ).catchError((onError){print("ERROR :${onError.toString()}");
      emit(CategoriesErrorState());
    });
  }

   CategoryDetailModel? categoriesDetailModel;
  List productDataCategory=[];
  void getDetailsCategory(idCategory)async{
    productDataCategory=[];productDataCategories=[];
    print("before ${categoriesDetailModel==null}");
    emit(CategoryDetailsLoadingState());

    DioHelper.getData(path:"categories/$idCategory", token: token).
    then((value) {

      categoriesDetailModel=CategoryDetailModel.toObject(value.data);
      print("total  ${categoriesDetailModel!.data.total}");
      print("after ${categoriesDetailModel==null}");
      /* categoriesDetailModel!.data.productData.forEach((element) {
         productDataCategories.add(element);
         productDataCategory.add(element);
      });print("hi ${categoriesDetailModel!.data.productData.length}");*/
      emit(CategoryDetailsSuccessState());
    })
        .catchError((onError){print("${onError.toString()}");
      emit(CategoryDetailsErrorState());
    });
  }

  /***********Favorite**************/
  FavoritesModel? favoritesModel;
  void getFavoritesItems(){
    emit(FavoritesLoadingState());
    DioHelper.getData(path: favoritePath,token: token).then((value) {
      favoritesModel=FavoritesModel.toObject(value.data);
      print("getFavoritesItems: ${favoritesModel!.data!.data.length}");
      emit(FavoritesSuccessState(favoritesModel!));
    }).catchError((onError){
     print("getFavoritesItems: ${onError.toString()}");
      emit(FavoritesErrorState());
    });
  }
  Map<int, bool> favorites = {};
  var itemsInFavorites = 0;
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(idProduct){
    favorites[idProduct]=!favorites[idProduct]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: favoritePath, token: token, data: {'product_id': idProduct},)
        .then((value) {
          changeFavoritesModel=ChangeFavoritesModel.toObject(value.data);
          print("message : ${changeFavoritesModel!.message}");
          if(!changeFavoritesModel!.status){
            print("message 2: ${changeFavoritesModel!.message}");
            favorites[idProduct]=!favorites[idProduct]!;
          }
          else{
            print("message 3: ${changeFavoritesModel!.message}");
            getFavoritesItems();
          }
          emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    })
        .catchError((onError){emit(ShopErrorChangeFavoritesState());
      print("addFavorite: ${onError.toString()}");
    });
    
  }
  void deleteFavoriteItems(idProduct){
    DioHelper.deleteData(url: favoritePath, data: {"product_id":idProduct})
        .then((value) {
      emit(DeleteFavoriteItemState());
    })
        .catchError((onError){
      print("deleteFavoriteItem: ${onError.toString()}");
    });

  }

  
  //get Details for Product
  ProductDetailsModel? productDetailsModel;
  void getProductDetails(int idProduct){
    emit(ProductDetailsLoadingState());
    DioHelper.getData(path: "$productDetailsPath/$idProduct",token: token)
        .then((value) {
          productDetailsModel=ProductDetailsModel.toObject(value.data);
          emit(ProductDetailsSuccessState(productDetailsModel!));
    }).
    catchError((onError){
          print("getProductDetails Error: ${onError.toString()}");
          emit(ProductDetailsErrorState());
    });
  }
//Search Product
  SearchProductModel? productSearchModel;
  void getSearchProduct(String text){
    emit(SearchProductLoadingState());
    DioHelper.postData(url: searchProductPath,token: token,data: {'text':text})
        .then((value) {
      productSearchModel=SearchProductModel.toObject(value.data);
      emit(SearchProductSuccessState(productSearchModel!));
    })
        .catchError((onError) {
      print("getSearchProduct Error: ${onError.toString()}");
      emit(SearchProductErrorState());
    });
  }
  //carts
  CartsModel? cartsModel;
  void getCarts(){
    emit(CartsLoadingState());
    DioHelper.getData(path:cartsPath ,token: token)
        .then((value) {
      cartsModel=CartsModel.toObject(value.data);
      emit(CartsSuccessState());
    })
        .catchError((onError){
      print("get Error: ${onError.toString()}");
      emit(CartsErrorState());
    });
  }
  ChangeCartModel? changeCartModel;
  void getChangeCart(int idProduct){
    emit(ChangeCartLoadingState());
    DioHelper.postData(url:cartsPath ,token: token,data:{"product_id": idProduct} )
        .then((value) {
      changeCartModel=ChangeCartModel.toObject(value.data);
      emit(ChangeCartSuccessState());
    })
        .catchError((onError){
      print("get Error: ${onError.toString()}");
      emit(ChangeCartErrorState());
    });
  }
  UpdateCartModel? updateCartModel;
  void getUpdateCart(int idCart){
    emit(UpdateCartLoadingState());
    DioHelper.postData(url:cartsPath ,token: token,data:{"quantity": idCart} )
        .then((value) {
      updateCartModel=UpdateCartModel.toObject(value.data);
      emit(UpdateCartSuccessState());
    })
        .catchError((onError){
      print("getUpdateCart Error: ${onError.toString()}");
      emit(UpdateCartErrorState());
    });
  }
  DeleteCartModel? deleteCartModel;
  void deleteCart(int idCart){
    emit(DeleteCartLoadingState());
    DioHelper.deleteData(url: "${cartsPath}/${idCart}", data: {},token: token)
        .then((value) {
      deleteCartModel=DeleteCartModel.toObject(value.data);
      emit(DeleteCartSuccessState());
    })
        .catchError((onError){});
    print("deleteCart Error: ${onError.toString()}");
    emit(DeleteCartErrorState());
  }




}