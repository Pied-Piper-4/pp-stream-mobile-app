import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp_stream_mobile_app/constant/assets_constants.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/constant/page_routes.dart';
import 'package:pp_stream_mobile_app/widgets/reusable.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: isActive ? 10.0 : 10.0,
      width: isActive ? 35.6 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : primaryColor.withOpacity(.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: dimmedWhiteBackgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child:
                      // SizedBox(width: width*0.8,),
                      Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _pageController.jumpToPage(3);
                        });
                      },
                      child: _currentPage == _numPages - 1
                          ? Container()
                          : const Text(
                              'Skip',
                              style: TextStyle(
                                color: grayButtonColor,
                                fontFamily: "Sofia",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _currentPage == _numPages - 1
                      ? height * 0
                      : height * 0.03,
                ),
                SizedBox(
                  height: height * 0.6,
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      onBoardingSlide(
                        size: size,
                        imagePath: streamImage,
                        title: 'Stream As You Go',
                        desc:
                            'Streamming has been made easy with PP Stream. You can stream as you go with our app.',
                      ),
                      onBoardingSlide(
                        size: size,
                        imagePath: chatImage,
                        title: 'Chat With Your Friends',
                        desc:
                            'Chat while you are on the go, with your friends and family',
                      ),
                     
                      onBoardingSlide(
                        size: size,
                        imagePath: videoCallImage,
                        title: 'Video Call anyone',
                        desc:
                            'You can also make video call to your friends and family',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _currentPage == _numPages - 1
                      ? height * 0
                      : height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                _currentPage == _numPages - 1
                    ? Column(
                        children: [
                          roundedIconButton(
                              svgImagePath: getStartedIcon,
                              width: width * 0.9,
                              text: "Get Started",
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  loginRoute,
                                );
                              }),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
