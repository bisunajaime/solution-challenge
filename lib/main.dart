import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/pages/onboarding_page.dart';
import 'package:helpinghand/utils/data_utils.dart';
import 'package:helpinghand/widgets/checklocation_widget.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataUtils(),
        ),
      ],
      child: MaterialApp(
        title: 'Helping Hand PH',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: mainColor,
            textTheme: TextTheme(
              title: TextStyle(
                fontFamily: mBlack,
              ),
            ),
          ),
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: mBlack,
            ),
            subtitle: TextStyle(
              fontFamily: mBold,
            ),
            body1: TextStyle(
              fontFamily: mMedium,
            ),
            body2: TextStyle(
              fontFamily: mRegular,
            ),
          ),
        ),
        home: CheckLocationWidget(),
      ),
    );
  }
}
