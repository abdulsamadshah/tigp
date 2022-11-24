import 'package:finalcode/settings.dart';
import 'package:finalcode/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'magazine.dart';
import 'news.dart';

// function to trigger the app build
void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF7B19AA),
          title: new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "TIGP",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Racer',
                fontSize: 28,
                color: Color(0xFFF57F17),
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return ui.Gradient.linear(
                      Offset(4.0, 24.0),
                      Offset(24.0, 4.0),
                      [
                        Color(0xFFF57F17),
                        Color(0xFFFFEE58),
                      ],
                    );
                  },
                  child: Icon(Icons.settings)),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFF999966),
            labelStyle: TextStyle(fontSize: 11, fontFamily: 'Copper'),
            tabs: [
              Tab(
                icon: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return ui.Gradient.linear(
                      Offset(4.0, 24.0),
                      Offset(24.0, 4.0),
                      [
                        Color(0xFF999966),
                        Color(0xFFd6d6c2),
                      ],
                    );
                  },
                  child: Icon(Icons.article_outlined, size: 30),
                ),
                text: "NEWS",
              ),
              Tab(
                icon: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ui.Gradient.linear(
                        Offset(4.0, 24.0),
                        Offset(24.0, 4.0),
                        [
                          Color(0xFF999966),
                          Color(0xFFd6d6c2),
                        ],
                      );
                    },
                    child: Icon(Icons.video_call_outlined, size: 30)),
                text: "Videos",
              ),
              Tab(
                icon: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ui.Gradient.linear(
                        Offset(4.0, 24.0),
                        Offset(24.0, 4.0),
                        [
                          Color(0xFF999966),
                          Color(0xFFd6d6c2),
                        ],
                      );
                    },
                    child: Icon(Icons.book_outlined, size: 30)),
                text: "Magzine",
              ),
              Tab(
                icon: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ui.Gradient.linear(
                        Offset(4.0, 24.0),
                        Offset(24.0, 4.0),
                        [
                          Color(0xFF999966),
                          Color(0xFFd6d6c2),
                        ],
                      );
                    },
                    child: Icon(Icons.web, size: 30)),
                text: "Website",
              ),
            ],
          ),
        ), // AppBar
        body: WillPopScope(
          onWillPop: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return Future.value(true);
          },

          child: TabBarView(
            children: [
              News(),
              Video(),
              Magazine(),
            ],
          ), // TabBarView
        ), // Scaffold
      ), // DefaultTabController
    )); // MaterialApp
  }
}
