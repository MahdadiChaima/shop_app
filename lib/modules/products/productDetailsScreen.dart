import 'package:ap/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ap/layout/Shop/Cubit/cubit.dart';
import 'package:ap/layout/Shop/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/components.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int id;
  const ProductDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    cubit.getProductDetails(id);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (state.model.status == false) {
            defaultSnackBarMaterial(context,Colors.redAccent,state.model.message);

          }
        }

        if (state is ShopErrorChangeFavoritesState) {
          defaultSnackBarMaterial(context,Colors.redAccent,"No Internet Connection");

        }
      },
      builder: (context, state) {
        return Scaffold(backgroundColor: primaryLightColor,
            appBar: AppBar(backgroundColor: primaryLightColor,
                toolbarHeight: 80,
                title: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: defaultText(
                      text: "Product Details",
                      fontSize: 24,color: primaryColor,
                      fontWeight: FontWeight.w500,
                      googleFont: true),
                )),
            body: cubit.productDetailsModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(
                            color: primaryColor,
                            width: 0.2,
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        Image.network(
                                          '${cubit.productDetailsModel!.data!.image}',
                                          fit: BoxFit.fill,
                                          height: 250,
                                          width: double.infinity,
                                        ),
                                        if (cubit.productDetailsModel!.data!
                                                .discount! >
                                            0)
                                          Container(
                                            color: Colors.redAccent,
                                            child: defaultText(
                                                text: "Discount",
                                                googleFont: true,
                                                fontSize: 24,
                                                color: Colors.white),
                                          )
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${cubit.productDetailsModel!.data!.name}",
                                    style: GoogleFonts.signika(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24),

                                    //  const TextStyle(overflow: TextOverflow.ellipsis,fontSize: 26,
                                    //fontWeight: FontWeight.w600),
                                    maxLines: 3,
                                  ),
                                  Row(
                                    children: [
                                      defaultText(
                                          text:
                                              "${cubit.productDetailsModel!.data!.price!.round()}",
                                          googleFont: true,
                                          fontWeight: FontWeight.w700,
                                          color: primaryColor),
                                      const SizedBox(
                                        width: 44,
                                      ),
                                      if (cubit.productDetailsModel!.data!
                                              .discount! >
                                          0)
                                        Text(
                                          "${cubit.productDetailsModel!.data!.oldPrice!.round()}",
                                          style: const TextStyle(
                                              color: Colors.black26,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            ShopCubit.get(context)
                                                .changeFavorites(cubit
                                                    .productDetailsModel!
                                                    .data!
                                                    .id);
                                          },
                                          icon: cubit.favorites[cubit
                                                      .productDetailsModel!
                                                      .data!
                                                      .id] ==
                                                  false
                                              ? const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: Colors.black26)
                                              : Icon(
                                                  Icons.favorite,
                                                  color: primaryColor,
                                                ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Divider(height: 0.1, color: primaryColor),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  defaultText(
                                      text: "Description:",
                                      fontSize: 20,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                      googleFont: true),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  defaultText(
                                      text:
                                          "${cubit.productDetailsModel!.data!.description}")
                                ]),
                          ),
                        ))));
      },
    );
  }
}
