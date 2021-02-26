import 'dart:math';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'const.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random _random = Random();
  Color _color = Color(0xFFFFFFFF);

  void changeToRandomColor() {
    setState(() {
      _color = Color.fromARGB(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kAppBarTitle),
        leading: IconButton(
          icon: Image.asset('assets/color.png'),
          onPressed: () { },

        ),
      ),
      body: Stack(
        children: [
          InkWell(
            onTap: changeToRandomColor,
            child: Container(
                color: _color,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kMainText.text.size(75).semiBold.white.make().shimmer(
                          primaryColor: Colors.transparent,
                          secondaryColor: Colors.white70),
                      SizedBox(
                        width: 250.0,
                        child: ColorizeAnimatedTextKit(
                          onTap: () {},
                          text: [
                            kSubText,
                          ],
                          textStyle:
                          TextStyle(fontSize: 16.0, fontFamily: "Horizon"),
                          colors: [
                            Colors.blueGrey,
                            Colors.yellowAccent,
                            Colors.cyanAccent,
                            Colors.redAccent,
                            Colors.greenAccent,
                          ],
                        ),
                      ),
                      Container(
                        child: _bottomWave(),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

Widget _bottomWave() {
  return Container(
    child: ClipPath(
      child: Container(
        color: Colors.white24,
        height: 100,
      ),
      clipper: BottomWaveClipper(),
    ),
    alignment: Alignment.bottomCenter,
  );
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 2);

    var secondControlPoint = Offset(size.width - (size.width / 8), size.height);
    var secondEndPoint = Offset(size.width, 0.0);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    return path;

    throw UnimplementedError();
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
