import 'package:ap/layout/Shop/Cubit/cubit.dart';
import 'package:ap/layout/Shop/Cubit/states.dart';
import 'package:ap/models/categories/categoryDetailsModel.dart';
import 'package:ap/modules/products/productDetailsScreen.dart';
import 'package:ap/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/colors.dart';

class CategoryDetailsScreenScreen extends StatelessWidget {
  final int? idProduct;
  const CategoryDetailsScreenScreen(this.idProduct, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getDetailsCategory(idProduct);
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) { if (state is ShopSuccessChangeFavoritesState) {
          if (state.model.status == false) {
            defaultSnackBarMaterial(context,Colors.redAccent,state.model.message);

          }
          else{
            defaultSnackBarMaterial(context,Colors.green,state.model.message);
          }
        }},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(backgroundColor: primaryLightColor,
                  toolbarHeight: 80,
                  title: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: defaultText(
                        text: "Category Details",
                        fontSize: 24,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        googleFont: true),
                  )),
              backgroundColor: primaryLightColor,
              body: state is! CategoryDetailsSuccessState
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 1 / 1.47,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: List.generate(
                                ShopCubit.get(context)
                                    .categoriesDetailModel!
                                    .data
                                    .productData
                                    .length,
                                (index) => buildCategoryDetailsWidget(
                                    ShopCubit.get(context)
                                        .categoriesDetailModel!
                                        .data
                                        .productData[index],
                                    context)),
                          ),
                        ],
                      ),
                    ));
        });
  }

  buildCategoryDetailsWidget(ProductDataCategory product, context) {
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
                borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                              Container(
                                child: defaultText(
                                    text: "Discount",
                                    googleFont: true,
                                    color: Colors.white),
                                color: thirdColor,
                              )
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${product.name}",
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
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
                              style: const TextStyle(
                                  color: Colors.black26,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorites(product.id);
                              },
                              icon:
                                  ShopCubit.get(context).favorites[product.id] ==
                                          false
                                      ? const Icon(Icons.favorite_border_outlined,
                                          color: Colors.black26)
                                      : Icon(
                                          Icons.favorite,
                                          color: primaryColor,
                                        ))
                        ],
                      )
                    ]),
              ))),
    );
  }
}
