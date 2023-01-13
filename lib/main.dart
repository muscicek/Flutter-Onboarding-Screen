import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  PageController controller = PageController(initialPage: 0);
  bool onLastPage = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            buildPage(
              color: Color(0xffC2B28F),
              imageSource: "assets/qwere.png",
              textPage: "Page1",
              textInfo:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                  "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
            ),
            buildPage(
              color: Color(0xffAFA081),
              imageSource: "assets/asdre.png",
              textPage: "Page2",
              textInfo:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                  "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
            ),
            buildPage(
              color: Color(0xff9B8E72),
              imageSource: "assets/ertre.png",
              textPage: "Page3",
              textInfo:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                  "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
            ),
          ],
        ),
      ),
      bottomSheet: onLastPage
          ? TextButton(
              onPressed: () {},
              child: Text("Done"),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                backgroundColor: Color(0xff83B799),
                minimumSize: Size.fromHeight(80),
                primary: Colors.white,
              ),
            )
          : Container(
              color: Color(0xff83B799),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                    onPressed: () => controller.jumpToPage(2),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.deepOrange,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                    onPressed: () => controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class buildPage extends StatelessWidget {
  final Color? color;
  final String? imageSource;
  final String? textPage;
  final String? textInfo;
  buildPage(
      {required this.color,
      required this.imageSource,
      required this.textPage,
      required this.textInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color(0xffc7bfe6),
      color: color!!,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageSource!,
              fit: BoxFit.scaleDown,
              width: MediaQuery.of(context).size.height / 2,
            ),
            Text(
              textPage!,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 10,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 43),
              child: Text(
                textInfo!,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
