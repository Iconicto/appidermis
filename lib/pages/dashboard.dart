import 'package:appidermis/widgets/previous_disease_cards.dart';
import 'package:appidermis/widgets/recent_lookup_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class DashboardPage extends StatelessWidget {
  static ScreenScaler _scaler;
  @override
  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Dashboard",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _scaler.getTextSize(20.0),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              height: _scaler.getHeight(20),
              child: Image.asset(
                'assets/images/dashboard_medicine.png',
                width: _scaler.getWidth(90),
              ),
            ),
            SizedBox(height: _scaler.getHeight(1.0)),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recently Reported Diseases",
                style: TextStyle(
                  fontSize: _scaler.getTextSize(12.0),
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: _scaler.getHeight(0.5)),
            PreviousDiseaseCards(),
            SizedBox(height: _scaler.getHeight(2)),
            _buildRecentLookupTitle(),
            RecentLookupCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLookupTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "Your recent lookups",
        style: TextStyle(
          fontSize: _scaler.getTextSize(13),
          color: Colors.grey,
        ),
      ),
    );
  }
}
