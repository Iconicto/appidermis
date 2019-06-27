import 'package:appidermis/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class PreviousDiseaseCards extends StatelessWidget {
  final List<Map<String, dynamic>> diseasesInfo = [
    {'name': "Melanocytic Nevi", 'isBookmarked': false, 'numberOfReports': 5},
    {'name': "Melanoma", 'isBookmarked': false, 'numberOfReports': 2},
    {'name': "Benign Lesions", 'isBookmarked': false, 'numberOfReports': 15},
    {
      'name': "Basal Cell Carcinoma",
      'isBookmarked': false,
      'numberOfReports': 8
    },
    {'name': "Actinic Keratoses", 'isBookmarked': false, 'numberOfReports': 4},
    {'name': "Vascular Lesions", 'isBookmarked': false, 'numberOfReports': 7},
    {'name': "Dermatofibroma", 'isBookmarked': false, 'numberOfReports': 20},
  ];

  static ScreenScaler _scaler = ScreenScaler();

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return PreviousDiseaseCard(diseaseInfo: diseasesInfo[index]);
      },
      itemCount: 7,
      itemWidth: _scaler.getWidth(80),
      itemHeight: _scaler.getHeight(25),
      layout: SwiperLayout.STACK,
    );
  }
}

class PreviousDiseaseCard extends StatefulWidget {
  final Map<String, dynamic> diseaseInfo;

  PreviousDiseaseCard({this.diseaseInfo});

  @override
  _PreviousDiseaseCardState createState() => _PreviousDiseaseCardState();
}

class _PreviousDiseaseCardState extends State<PreviousDiseaseCard> {
  ScreenScaler _scaler = ScreenScaler();

  Widget _buildButton(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          _scaler.getHeight(0.5), 0.0, _scaler.getHeight(0.5), 0.0),
      width: _scaler.getWidth(28.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color,
        ),
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Opacity(
              opacity: 0.6,
              child: Icon(
                icon,
                size: _scaler.getHeight(2.5),
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 2.5, 0.0, 0.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: _scaler.getTextSize(11.5),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(_scaler.getWidth(5), _scaler.getWidth(5),
            _scaler.getHeight(2), _scaler.getHeight(2)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.diseaseInfo['isBookmarked']
                      ? widget.diseaseInfo['isBookmarked'] = false
                      : widget.diseaseInfo['isBookmarked'] = true;
                });
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: widget.diseaseInfo['isBookmarked']
                    ? Icon(
                        Icons.bookmark,
                        color: AppColors.PINK,
                        size: _scaler.getHeight(3.5),
                      )
                    : Icon(
                        Icons.bookmark_border,
                        color: AppColors.PINK,
                        size: _scaler.getHeight(3.5),
                      ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.diseaseInfo['name'],
                      style: TextStyle(
                        fontSize: _scaler.getTextSize(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: _scaler.getHeight(0.4)),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${widget.diseaseInfo['numberOfReports']} Reports",
                      style: TextStyle(
                        fontSize: _scaler.getTextSize(12),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: _scaler.getHeight(4)),
                  Row(
                    children: <Widget>[
                      _buildButton("Info", Icons.info, AppColors.PINK),
                      _buildButton(
                          "Report", Icons.arrow_forward, AppColors.AQUA)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
