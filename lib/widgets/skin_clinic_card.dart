import 'package:appidermis/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:url_launcher/url_launcher.dart';

class SkinClinicCard extends StatelessWidget {
  SkinClinicCard({
    Key key,
    this.image,
    this.rating,
    this.address,
    this.mapURL,
    this.clinicName,
  }) : super(key: key);
  final String image;
  final String rating;
  final String address;
  final String mapURL;
  final String clinicName;

  static ScreenScaler _scaler = ScreenScaler();

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: _scaler.getHeight(40), //4107,
        width: _scaler.getWidth(43),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image.network(
                image,
                height: _scaler.getHeight(10),
                fit: BoxFit.contain,
              ),
            ),
            // SizedBox(height: 10.0),
            Container(
              child: Text(clinicName,
                  style: TextStyle(
                    fontSize: _scaler.getWidth(4.5),
                  )),
            ),
            // SizedBox(height: 10.0),
            Container(
              alignment: Alignment.center,
              child: Text(
                address,
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(height: 10.0),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: GestureDetector(
                onTap: () => _launchURL(mapURL),
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "View",
                        style: TextStyle(
                          color: AppColors.AQUA,
                          fontSize: _scaler.getTextSize(12),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
