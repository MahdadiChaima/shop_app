import 'package:ap/layout/Shop/Cubit/cubit.dart';
import 'package:ap/layout/Shop/Cubit/states.dart';
import 'package:ap/modules/products/productDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/favourites/favoritesModel .dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is FavoritesLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (ShopCubit.get(context).favoritesModel == null ||
                      ShopCubit.get(context)
                              .favoritesModel!
                              .data!
                              .data
                              .length ==
                          0)
                  ? Center(
                    child: Column(
                        children: [
                          SizedBox(height: 100,),
                          Container(
                              child: CircleAvatar(
                            radius: 100,
                            child: Icon(
                              Icons.favorite_outlined,
                              color: Colors.white,size: 100,
                            ),
                            backgroundColor: primaryColor,
                          )),
                          SizedBox(height: 15,),
                          defaultText(
                              text: "No favourites yet!",
                              googleFont: true,
                              fontWeight: FontWeight.w600,
                              fontSize: 24)
                        ],
                      ),
                  )
                  : SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                            ShopCubit.get(context)
                                .favoritesModel!
                                .data!
                                .data
                                .length,
                            (index) => buildProductWidget(
                                ShopCubit.get(context)
                                    .favoritesModel!
                                    .data!
                                    .data[index],
                                context)),
                      ),
                    );
        });
  }

  buildProductWidget(FavoritesData data, context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            navigateTo(context, ProductDetailsScreen(id: data.id!));
          },
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
                                "${data.product!.image}",
                                fit: BoxFit.fill,
                                height: 120,
                                width: 120,
                              ),
                              if (data.product!.discount > 0)
                                Container(
                                  color: Colors.redAccent,
                                  child: defaultText(
                                      text: "Discount",
                                      googleFont: true,
                                      color: Colors.white),
                                )
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
                              "${data.product!.name}",
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
                                    text: "${data.product!.price}",
                                    googleFont: true,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor),
                                const SizedBox(
                                  width: 20,
                                ),
                                if (data.product!.discount > 0)
                                  Text(
                                    "${data.product!.oldPrice}",
                                    style: const TextStyle(
                                        color: Colors.black26,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      ShopCubit.get(context)
                                          .changeFavorites(data.product!.id);
                                    },
                                    icon: ShopCubit.get(context)
                                                .favorites[data.product!.id] ==
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
              )),
        ));
  }
}
