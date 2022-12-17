import 'package:ap/layout/Shop/Cubit/cubit.dart';
import 'package:ap/layout/Shop/Cubit/states.dart';
import 'package:ap/modules/search/searchScreen.dart';
import 'package:ap/shared/components/components.dart';
import 'package:ap/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayoutScreen extends StatefulWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  State<ShopLayoutScreen> createState() => _ShopLayoutScreenState();
}

class _ShopLayoutScreenState extends State<ShopLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopCubit>(context)
        ..getHomeData()
        ..getFavoritesItems()
        ..getCategories(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return Scaffold(backgroundColor: primaryLightColor,
            appBar: AppBar(toolbarHeight: 50,backgroundColor: primaryLightColor,
              title:Padding(
              padding: const EdgeInsets.all(15.0),
              child: defaultText(text:ShopCubit.get(context).appBarTitle[ShopCubit.get(context).indexNavBar],
              fontSize: 25,fontWeight: FontWeight.w500,googleFont: true),
            ) ,
              actions: [IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon:const  Icon(Icons.search))],
            ),
            body: ShopCubit.get(context).widget,
            bottomNavigationBar: BottomNavigationBar(backgroundColor: primaryLightColor,
              onTap: (index) {
                ShopCubit.get(context).changeBottomBar(index);

              },
              currentIndex: ShopCubit.get(context).indexNavBar,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: "Products",backgroundColor: secondColor),
                BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view), label: "Categories"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_outlined),
                    label: "Favorite"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ],

            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
