import 'package:ap/layout/Shop/Cubit/cubit.dart';
import 'package:ap/layout/Shop/Cubit/states.dart';
import 'package:ap/models/home/ShopHomeModel.dart';
import 'package:ap/modules/products/productDetailsScreen.dart';
import 'package:ap/shared/components/components.dart';
import 'package:ap/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopSuccessChangeFavoritesState) {
          if (state.model.status == false) {
            defaultSnackBarMaterial(context,Colors.redAccent,state.model.message);

          }
          else{
            defaultSnackBarMaterial(context,Colors.green,state.model.message);
          }
        }

        if (state is ShopErrorChangeFavoritesState) {
          defaultSnackBarMaterial(context,Colors.redAccent,"No Internet Connection");

        }},
        builder: (context, state) {
          return ShopCubit.get(context).shopHomeModel != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      buildBannerWidget(),
                     const SizedBox(
                        height: 5,
                      ),
                      GridView.count(
                        physics:const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1 / 1.48,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(products.length,
                            (index) => buildProductWidget(products[index],context)),
                      ),
                    ],
                  ),
                )
              :const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget buildBannerWidget() => CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration:const Duration(
              seconds: 1,
            ),
            initialPage: 0,
            viewportFraction: 1),
        items: banners.map((banner) {
          return Builder(
            builder: (BuildContext context) {
              return Image.network(
                "${banner.image}",
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: 240,
              );
            },
          );
        }).toList(),
      );

  buildProductWidget(ProductModel product,context) {
    var cubit=ShopCubit.get(context);
    return InkWell(onTap: (){
      navigateTo(context, ProductDetailsScreen(id:product.id!));
    },
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              height: 580,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white,
                border: Border.all(
                  color: primaryColor,
                  width: 0.2,
                ),
                shape: BoxShape.rectangle,
                borderRadius:const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Image.network(
                              '${product.image}',
                              fit: BoxFit.fill,
                              height: 150,
                              width: double.infinity,
                            ),
                            if (product.discount > 0)
                              Container(color: Colors.redAccent,
                                child: defaultText(
                                    text: "Discount",
                                    googleFont: true,
                                    color: Colors.white),
                              )
                          ]),
                     const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${product.name}",
                        style:const TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),
                     const SizedBox(
                        height: 10,
                      ),
                      Divider(height: 0.1, color: primaryColor),
                      Row(
                        children: [
                          defaultText(
                              text: "${product.price.round()}",
                              googleFont: true,
                              fontWeight: FontWeight.w700,
                              color: primaryColor),
                         const SizedBox(
                            width: 20,
                          ),
                          if (product.discount > 0)
                            Text(
                              "${product.oldPrice.round()}",
                              style:const TextStyle(
                                  color: Colors.black26,
                                  decoration: TextDecoration.lineThrough),
                            ),
                         const Spacer(),
                          IconButton(onPressed: () {
                            ShopCubit.get(context).changeFavorites(product.id);
                          },
                              icon: cubit.favorites[product.id]==false?
                             const Icon(Icons.favorite_border_outlined,color: Colors.black26):
                              Icon(Icons.favorite,color: primaryColor,)
                          )
                        ],
                      )
                    ]),
              ))),
    );
  }
}
