import 'package:appidermis/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class RecentLookupCard extends StatelessWidget {
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
                        SizedBox(width: ScreenScaler().getWidth(10)),
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
                      "Skin Rash Detected",
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
                    SizedBox(height: ScreenScaler().getHeight(3),),
                    Text(
                      "Take me to the closest Skin Clinic",
                      style: TextStyle(
                        fontSize: ScreenScaler().getTextSize(13),
                        color: AppColors.AQUA,
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
