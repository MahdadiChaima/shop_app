import 'package:ap/layout/Shop/Cubit/cubit.dart';
import 'package:ap/layout/Shop/Cubit/states.dart';
import 'package:ap/models/products/productSearchModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../products/productDetailsScreen.dart';

var searchController = TextEditingController();

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessChangeFavoritesState) {
        if (state.model.status == false) {
          defaultSnackBarMaterial(
              context, Colors.redAccent, state.model.message);
        } else {
          defaultSnackBarMaterial(context, Colors.green, state.model.message);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: primaryLightColor,
          appBar: AppBar(
            backgroundColor: primaryLightColor,
          ),
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    ShopCubit.get(context).getSearchProduct(value);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              state is SearchProductLoadingState
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ShopCubit.get(context).productSearchModel == null
                      ? error("Please Enter Product name")
                      : ShopCubit.get(context)
                                  .productSearchModel!
                                  .data
                                  .productData
                                  .length ==
                              0
                          ? error("There is no product have this name")
                          : Column(
                              children: List.generate(
                                  ShopCubit.get(context)
                                      .productSearchModel!
                                      .data
                                      .productData
                                      .length,
                                  (index) => buildProductWidget(
                                      ShopCubit.get(context)
                                          .productSearchModel!
                                          .data
                                          .productData[index],
                                      context)),
                            )
            ]),
          ));
    });
  }

  buildProductWidget(ProductData data, context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, ProductDetailsScreen(id: data.id!));
      },
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: primaryColor,
                  width: 0.2,
                ),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Image.network(
                                "${data.image}",
                                fit: BoxFit.fill,
                                height: 120,
                                width: 120,
                              ),
                            ]),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${data.name}",
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                defaultText(
                                    text: "${data.price}",
                                    googleFont: true,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      ShopCubit.get(context)
                                          .changeFavorites(data.id);
                                    },
                                    icon: ShopCubit.get(context)
                                                .favorites[data.id] ==
                                            false
                                        ? const Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.black26)
                                        : Icon(
                                            Icons.favorite,
                                            color: primaryColor,
                                          ))
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
              ))),
    );
  }

  Widget error(String text) =>  Center(
    child: Column(
      children: [
        SizedBox(height: 100,),
        Container(
            child: CircleAvatar(
              radius: 100,
              child: Icon(
                Icons.search_off_sharp,
                color:Colors.deepOrange,size: 100,
              ),
              backgroundColor: Colors.white ,
            )),
        SizedBox(height: 25,),
        defaultText(
            text: text,
            googleFont: true,
            fontWeight: FontWeight.w400,
            fontSize: 20)
      ],
    ),

  );
}
