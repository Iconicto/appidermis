import 'package:appidermis/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:url_launcher/url_launcher.dart';

class RecentLookupCard extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add_alert,
                          color: AppColors.PINK,
                        ),
                        SizedBox(width: ScreenScaler().getWidth(13)),
                        Text(
                          "Positive Results",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenScaler().getTextSize(15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.close,
                      color: AppColors.AQUA,
                    ),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(7.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Skin Cancer Detected",
                      style: TextStyle(
                        fontSize: ScreenScaler().getTextSize(12),
                      ),
                    ),
                    Text(
                      "Needs Attention",
                      style: TextStyle(
                        fontSize: ScreenScaler().getTextSize(12),
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: ScreenScaler().getHeight(3),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchURL(
                            'https://www.google.com/maps/place/Durdans+Hospital/@6.9020579,79.8513089,17z/data=!3m1!4b1!4m5!3m4!1s0x3ae2596094db18b9:0xb0ffe5ca94529291!8m2!3d6.9020526!4d79.8535029');
                      },
                      child: Text(
                        "Take me to the closest Skin Clinic",
                        style: TextStyle(
                          fontSize: ScreenScaler().getTextSize(13),
                          color: AppColors.AQUA,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
