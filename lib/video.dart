import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:finalcode/subscribe.dart';
import 'package:finalcode/videodetail.dart';
import 'package:finalcode/videomodel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'magazineModel.dart';

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
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

class Video extends StatefulWidget {
  @override
  State<Video> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Video> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _counter = 0;
  var apiurl;
  var apikey;
  var accesstoken;
  var weburl;
  late Future<List<myData>> hello;
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

  Future<List<myData>> getResponse() async {
    List<myData> list;

    var url =
        Uri.parse("http://freecart.in/abc/adminvideo/mobileapi/getvideo.php");
    http.Response response = await http.post(
      url,
    );

    print("Response" + response.body);
    var data1 = json.decode(response.body);

    var rest = data1["data"] as List<dynamic>;

    list = rest.map<myData>((json) => myData.fromJson(json)).toList();

    return list;
  }

  int _current = 0;

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF7B19AA),
        body: Stack(children: [
          Column(children: [
            Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(),
                  child: FutureBuilder<List<myData>?>(
                      future: hello,
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return listViewWidget(
                              (List<myData>.from(snapshot.data!)), context);
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
                      color: Colors.black,
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

  Widget listViewWidget(List<myData>? article, BuildContext context) {
    return Container(
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: article?.length,
            itemBuilder: (context, position) {
              var type = article![position].type;
              return GestureDetector(
                  onTap: () {
                    if (type == 'Free') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(
                                task: article![position],
                              )));
                    } else {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Subscribe()));
                    }
                  },
                  child: Container(
                      width: 180,
                      height: 180,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network(
                              getYoutubeThumbnail(
                                  'https://www.youtube.com/watch?v=' +
                                      article![position].youtubeid.toString()),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(8),
                          ),
                          SizedBox(
                              child: Text(
                            article[position].toString(),
                            style: TextStyle(
                              fontFamily: 'Copper',
                              color: Colors.white,
                            ),
                          ))
                        ]),
                      )));
            }));
  }
}
