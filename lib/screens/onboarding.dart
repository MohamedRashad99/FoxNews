import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
//import 'package:shared_preferences/shared_preferences.dart';


import '../pagemodel.dart';
import 'home_screen.dart';

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
          '1- We did it! If want any breaking news you can following it easily, you can click .',
          'assets/images/bbbb.jpg',
          Icons.camera),
    );
    Pages.add(
      PageModel(
          'FaceBook',
          '2- All facebook features or news you can watching or following her easily .',
          'assets/images/ff.jpg',
          Icons.add_location),
    );
    Pages.add(
      PageModel(
          'Instagram',
          '3- All instagram features or news you can watching or following her easily with some more notes .',
          'assets/images/i.jpg',
          Icons.hotel),
    );
    Pages.add(
      PageModel(
          'Twitter',
          '4- All twitter features or news you can watching or following her easily with some more notes',
          'assets/images/t.jpg',
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
