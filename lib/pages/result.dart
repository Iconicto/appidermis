import 'dart:convert';
import 'dart:io';
import 'package:appidermis/helpers/app_colors.dart';
import 'package:appidermis/pages/main.dart';
import 'package:appidermis/widgets/skin_clinic_card.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key key, this.image}) : super(key: key);
  final File image;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Map skinCancer;

  Future getClassification() async {
    List<int> imageBytes = widget.image.readAsBytesSync();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);

    var url = 'https://appidermis.iconicto.com/predict/';
    var response = await http.post(url, body: {
      'b64': base64Image,
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map value = jsonDecode(response.body);

    var firebaseURL =
        'https://appidermis.firebaseio.com/diseases/${value['prediction']}.json';
    var firebaseResponse = await http.get(firebaseURL);

    print('Firebase Response status: ${firebaseResponse.statusCode}');
    print('Firebase Response body: ${firebaseResponse.body}');

    setState(() {
      skinCancer = jsonDecode(firebaseResponse.body);
    });
  }

  @override
  void initState() {
    getClassification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MainPage(),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.file(
                widget.image,
                height: _scaler.getHeight(30),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              skinCancer == null
                  ? Container(
                      height: _scaler.getHeight(65),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(
                                strokeWidth: 4.0,
                                backgroundColor: AppColors.PINK,
                              ),
                              height: _scaler.getHeight(8),
                              width: _scaler.getWidth(17),
                            ),
                            SizedBox(height: _scaler.getHeight(2.5)),
                            Text(
                              "Loading",
                              style: TextStyle(
                                fontSize: _scaler.getTextSize(15),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              skinCancer['name'],
                              style: TextStyle(
                                fontSize: _scaler.getTextSize(18),
                                fontWeight: FontWeight.bold,
                                color: AppColors.AQUA,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              skinCancer['description'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: _scaler.getTextSize(13.5),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Symptoms",
                              style: TextStyle(
                                fontSize: _scaler.getTextSize(15),
                                fontWeight: FontWeight.bold,
                                color: AppColors.AQUA,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              skinCancer['symptoms'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: _scaler.getTextSize(13.5),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Remedies",
                              style: TextStyle(
                                fontSize: _scaler.getTextSize(15),
                                fontWeight: FontWeight.bold,
                                color: AppColors.AQUA,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              skinCancer['remedy'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: _scaler.getTextSize(13.5),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Suggested Clinics",
                              style: TextStyle(
                                fontSize: _scaler.getTextSize(15),
                                fontWeight: FontWeight.bold,
                                color: AppColors.AQUA,
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SkinClinicCard(
                                    image: "https://i.imgur.com/k6Lv68r.png",
                                    address:
                                        "No5, Arunachalam Avenue, Horton Pl, 00700",
                                    clinicName: "Amaran Aesthetic",
                                    mapURL:
                                        "https://goo.gl/maps/TT149QVoGE7fd1i68",
                                    rating: "10",
                                  ),
                                  SkinClinicCard(
                                    image:
                                        "http://www.lushsc.com/assets/images/home/lush_logo.png",
                                    address: "27 Vijayakumaratunga Mw, Colombo",
                                    clinicName: "LUSH Skin Clinic",
                                    mapURL: "http://www.lushsc.com/",
                                    rating: "5",
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
