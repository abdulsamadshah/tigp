import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:finalcode/subscribe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'newsdetail.dart';
import 'newsmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

class News extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<News> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<News> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _counter = 0;

  var userid;
  late Future<List<Datas>> hello;
  List _items = [];
  var image, galleryid;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    hello = getResponse();
  }

  getYoutubeThumbnail(String? videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl!);
    if (uri == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

  Future<List<Datas>> getResponse() async {
    List<Datas> list;

    var url =
        Uri.parse("http://freecart.in/abc/adminvideo/mobileapi/getnews.php");
    http.Response response = await http.post(
      url,
    );

    print("Response" + response.body);
    var data1 = json.decode(response.body);

    var rest = data1["data"] as List<dynamic>;

    list = rest.map<Datas>((json) => Datas.fromJson(json)).toList();

    return list;
  }

  int _current = 0;

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF921ec8),
        body: Stack(children: [
          Column(children: [
            Expanded(
                flex: 14,
                child: Container(
                  decoration: BoxDecoration(),
                  child: FutureBuilder<List<Datas>?>(
                      future: hello,
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return listViewWidget(
                              (List<Datas>.from(snapshot.data!)), context);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                )),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Subscribe()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0XFFa320df),
                    ),
                    child: Text(
                      "Subscribe Now",
                      style: TextStyle(
                        fontFamily: 'Copper',
                        color: Color(0xFFF57F17),
                      ),
                    ),
                  )),
            ),
          ]),
        ]));
  }

  Widget listViewWidget(List<Datas>? article, BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            color: Color(0XFF921ec8),
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(article!.length, (position) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewsDetails(
                                  task: article![position],
                                )));
                      },
                      child: SingleChildScrollView(
                          child: Column(children: [
                        Container(
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network(
                              article![position].image,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                          ),
                        ),
                        SizedBox(
                            child: Text(
                          article[position].name.substring(0, 10) + "...",
                          style: TextStyle(
                            fontFamily: 'Copper',
                            color: Colors.white,
                          ),
                        ))
                      ])));
                }))));
  }
}
