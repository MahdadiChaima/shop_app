import 'package:ap/layout/Shop/Cubit/cubit.dart';
import 'package:ap/layout/Shop/Cubit/states.dart';
import 'package:ap/models/categories/categoriesModel.dart';
import 'package:ap/modules/categories/categoryDetailsScreen.dart';
import 'package:ap/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: state is CategoriesLoadingState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ShopCubit.get(context).categoriesModel != null
                  ? Column(
                      children: List.generate(
                          ShopCubit.get(context)
                              .categoriesModel!
                              .data!
                              .data
                              .length, (index) {
                        return buildCardCategories(
                            ShopCubit.get(context)
                                .categoriesModel!
                                .data!
                                .data[index],
                            context);
                      }),
                    )
                  : Center(
                      child: Text("coming"),
                    ),
        );
      },
    );
  }

  Widget buildCardCategories(DataDataCategories categoriesData, context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child:
              ListTile(
                leading: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage("${categoriesData.image}"),
                ),
                title: Align(
                  alignment: Alignment(-1.3, 0),
                  child: defaultText(
                    text: "${categoriesData.name}",
                    googleFont: true,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      ShopCubit.get(context)
                          .getDetailsCategory("${categoriesData.id}");

                      navigateTo(context,
                          CategoryDetailsScreenScreen(categoriesData.id));
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined)))
          ],
        ),
      ),
    );
  }
}
