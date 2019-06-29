import 'dart:convert';

import 'package:appidermis/widgets/skin_clinic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:http/http.dart' as http;

class PartnerClinicPage extends StatefulWidget {
  const PartnerClinicPage({Key key}) : super(key: key);

  @override
  _PartnerClinicPageState createState() => _PartnerClinicPageState();
}

class _PartnerClinicPageState extends State<PartnerClinicPage> {
  List clinics;

  Future getData() async {
    var url = 'https://appidermis.firebaseio.com/clinics.json';
    var firebaseResponse = await http.get(url);
    setState(() {
      clinics = jsonDecode(firebaseResponse.body);
    });
    print('Firebase Response status: ${firebaseResponse.statusCode}');
    print('Firebase Response body: ${firebaseResponse.body}');
    print(clinics[0]['clinic_name']);
  }

  ScreenScaler _scaler = ScreenScaler();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 50.0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "Our Partnered Clinics",
              style: TextStyle(
                fontSize: _scaler.getTextSize(17),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Image.asset(
            'assets/images/partner_logo.png',
            height: _scaler.getHeight(25),
            width: _scaler.getWidth(25),
            fit: BoxFit.cover,
          ),
          clinics == null
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  height: _scaler.getHeight(56),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: new List<Widget>.generate(
                      clinics.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GridTile(
                            child: SkinClinicCard(
                              clinicName: clinics[index]['clinic_name'],
                              address: clinics[index]['address'],
                              mapURL: clinics[index]['map'],
                              rating: (clinics[index]['stars']),
                              image: clinics[index]['image'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
        ],
      ),
    ));
  }
}
