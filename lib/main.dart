import 'package:ap/layout/Shop/Cubit/cubit.dart';
import 'package:ap/layout/Shop/shop_layout_screen.dart';
import 'package:ap/shared/bloc_observer.dart';
import 'package:ap/shared/components/constants.dart';
import 'package:ap/shared/network/dioHelper.dart';
import 'package:ap/shared/network/local/cacheHelper.dart';
import 'package:ap/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/Shop/Cubit/states.dart';
import 'modules/login/logIn.dart';
import 'modules/onBoarding/on_boarding_screen.dart';
import 'modules/settings/cubit/cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //confirm that executed init Dio and cache
  Bloc.observer = MyBlocObserver(); //is to see me way state go
  DioHelper.init();
  await CacheHelper.init();
  dynamic onBoarding = false;

  onBoarding = CacheHelper.importData(key: 'onBoarding');
  token = CacheHelper.importData(key: 'token');

  Widget startWidget = const OnBoardingScreen();
  if (onBoarding != null) {
    if (token != null) {
      startWidget = const ShopLayoutScreen();
    } else {
      startWidget = const LogIn();
    }
  } else {
    startWidget = const OnBoardingScreen();
  }

  runApp(MyApp(startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProfileCubit()..getProfileData()..getAboutUs()),
          BlocProvider(
              create: (context)
              => ShopCubit()
                ..getHomeData()
                ..getFavoritesItems()
                ..getCategories()
          ),
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, state) {},
            builder: (context, state) {
             return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                home: OnBoardingScreen(),
              );
            }));
  }
}
