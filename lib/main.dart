// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nameList.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  int randomNum = 0;

  AnimationController? _controller;
  Animatable<Color> background = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTweenRitik(
          begin: Colors.red,
          end: Colors.green,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTweenRitik(
          begin: Colors.green,
          end: Colors.blue,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTweenRitik(
          begin: Colors.blue,
          end: Colors.pink,
        ),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  void onClick() {
    setState(() {
      randomNum = Random().nextInt(randomName.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedBuilder(
          animation: _controller!,
          builder: (context, child) {
            return Container(
              color: background
                  .evaluate(AlwaysStoppedAnimation(_controller!.value)),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Column(
                    children: [
                      Center(
                        child: Text(
                          'Generator',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                      Text(
                        'Random name generator',
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 0.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SizedBox(
                              height: 80.0,
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    randomName[randomNum].toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 5,
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                            width: 200.0,
                            height: 50.0,
                            child: ElevatedButton(
                              child: Text(
                                'GENERATE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 6,
                                    color: Colors.black),
                              ),
                              onPressed: () {
                                onClick();
                              },
                              style: ElevatedButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                primary: Colors.white,
                                shadowColor: Colors.black,
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: InkWell(
                              onTap: _launchURL,
                              child: Image.asset(
                                'assets/instagram.png',
                                scale: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: InkWell(
                              onTap: _launchtwitter,
                              child: Image.asset(
                                'assets/twitter.png',
                                scale: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 20),
                            child: InkWell(
                              onTap: _launchyoutube,
                              child: Image.asset(
                                'assets/youtube.png',
                                scale: 12,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      // backgroundColor: Colors.blue.shade600,
    );
  }

  static const _urlinsta = 'https://www.instagram.com/ritik_tanna/';

  void _launchURL() async => await canLaunch(_urlinsta)
      ? await launch(_urlinsta)
      : throw 'Could not launch $_urlinsta';

  static const _urltwitter = 'https://twitter.com/ritik_tanna';

  void _launchtwitter() async => await canLaunch(_urltwitter)
      ? await launch(_urltwitter)
      : throw 'Could not launch $_urltwitter';

  static const _urlyoutube =
      'https://www.youtube.com/channel/UCkfZgGLfOoNaFJ7rNFSNNQA';

  void _launchyoutube() async => await canLaunch(_urlyoutube)
      ? await launch(_urlyoutube)
      : throw 'Could not launch $_urlyoutube';
}

class ColorTweenRitik extends Tween<Color> {
  /// Creates a [Color] tween.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as transparent.
  ///
  /// We recommend that you do not pass [Colors.transparent] as [begin]
  /// or [end] if you want the effect of fading in or out of transparent.
  /// Instead prefer null. [Colors.transparent] refers to black transparent and
  /// thus will fade out of or into black which is likely unwanted.
  ColorTweenRitik({Color? begin, Color? end}) : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  Color lerp(double t) => Color.lerp(begin, end, t)!;
}
