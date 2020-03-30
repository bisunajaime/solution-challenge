import 'package:flutter/material.dart';
import 'package:helpinghand/main.dart';
import 'package:helpinghand/pages/home_page.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:latlong/latlong.dart';

class OnBoardingPage extends StatelessWidget {
  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', false);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();
    const PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontFamily: mBlack,
        fontSize: 30.0,
      ),
      imagePadding: EdgeInsets.symmetric(horizontal: 30.0),
      bodyTextStyle: TextStyle(
        fontFamily: mMedium,
      ),
    );
    return IntroductionScreen(
      key: introKey,
      onDone: () => _onIntroEnd(context),
      curve: Curves.fastOutSlowIn,
      animationDuration: 500,
      dotsDecorator: DotsDecorator(
        activeSize: Size.fromRadius(5),
        size: Size.fromRadius(2.5),
      ),
      next: Text(
        'Next',
        style: TextStyle(
          fontFamily: mMedium,
        ),
      ),
      pages: [
        PageViewModel(
          title: 'Helping Hand',
          body: 'Give out a helping hand to those in need during disasters',
          decoration: pageDecoration,
          image: Image(
            image: AssetImage(
              'assets/images/onboard-1.png',
            ),
          ),
        ),
        PageViewModel(
          title: 'Directions',
          body: 'Find the nearest help centers to drop your donations',
          decoration: pageDecoration,
          image: Image(
            filterQuality: FilterQuality.high,
            image: AssetImage(
              'assets/images/onboard-2.png',
            ),
          ),
        ),
        PageViewModel(
          title: 'You\'re all set!',
          body:
              'Instructions are written in the application, follow it and you\'re good to go!',
          decoration: pageDecoration,
          image: Image(
            image: AssetImage(
              'assets/images/onboard-3.png',
            ),
          ),
        ),
      ],
      done: Text(
        'Continue',
        style: TextStyle(fontFamily: mBold),
      ),
    );
  }
}
