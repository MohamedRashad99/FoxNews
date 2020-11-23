import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:container/pagemodel.dart';
import 'home_screen.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<PageModel> Pages = List<PageModel>();
  ValueNotifier<int> PageviewNotifier = ValueNotifier(0);

  void _addPages() {
    Pages.add(
      PageModel(
          'Welcome!',
          '1- We did it! If the download does not start in a couple of seconds, you can click .',
          'assets/images/cc.png',
          Icons.camera),
    );
    Pages.add(
      PageModel(
          'Map',
          '2- The following defines the version and build number for your application and get your direction .',
          'assets/images/cc2.png',
          Icons.add_location),
    );
    Pages.add(
      PageModel(
          'Hotel',
          '3- A version number is three numbers separated by dots, like 1.2.43 and can reserving in any time .',
          'assets/images/cc3.png',
          Icons.hotel),
    );
    Pages.add(
      PageModel(
          'House',
          '4- Both the version and the builder number may be overridden in flutter we have sales about all our houses ',
          'assets/images/cc4.png',
          Icons.flight),
    );
  }

  @override
  Widget build(BuildContext context) {
    _addPages();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(
                          Pages[index].images,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        child: Icon(
                          Pages[index].icon,
                          size: 150,
                          color: Colors.white,
                        ),
                        offset: Offset(0, -70),
                      ),
                      Text(
                        Pages[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 45, right: 48, top: 18),
                        child: Text(
                          Pages[index].discriptions,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: Pages.length,
            onPageChanged: (index) {
              PageviewNotifier.value = index;
            },
          ),
          Transform.translate(
            offset: Offset(0, 175),
            child: Align(
              alignment: Alignment.center,
              child: _displayPageindactor(Pages.length),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, right: 16, left: 16),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: RaisedButton(
                  color: Colors.red.shade900,
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          //_updateSeen();
                          return HomeScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayPageindactor(int length) {
    return PageViewIndicator(
      pageIndexNotifier: PageviewNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.red,
        ),
      ),
    );
  }

  // void _updateSeen() async{
  //   WidgetsFlutterBinding.ensureInitialized();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('seen', true);
  // }
}
