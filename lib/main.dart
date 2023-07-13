import 'package:api_project/Screens/createUser/createUserScreen.dart';
import 'package:api_project/Screens/homeScreen/homeScreen.dart';
import 'package:api_project/api/apiCall.dart';
import 'package:api_project/helpers/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ColorConsts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return apiProvideClass();
        },),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'API Project',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: appPrimary),
          primarySwatch: MaterialColor(primary, swatch),
          fontFamily: "Inter",
          appBarTheme: AppBarTheme(
            backgroundColor: appPrimary.withOpacity(0.8),
            elevation: 0,
            centerTitle: true,
            titleTextStyle: MyTextStyle.semiBold.copyWith(
              fontSize: 19,
            )
          )
        ),
        initialRoute: HomeScreen.pageName,
        routes: {
          HomeScreen.pageName : (context) =>  HomeScreen(),
          CreateUserScreen.pageName: (context) => CreateUserScreen()
        },
      ),
    );
  }
}