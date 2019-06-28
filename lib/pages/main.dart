import 'dart:io';

import 'package:appidermis/widgets/fab_with_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/app_colors.dart';
import '../widgets/fab_layout.dart';
import '../widgets/fab_with_icons.dart';
import '../widgets/navigation_bar.dart';
import 'dashboard.dart';
import 'partner_clinics.dart';
import 'result.dart';
import 'package:toast/toast.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _children = [
    DashboardPage(),
    PartnerClinicPage(),
  ];

  int _navSelectedIndex = 0;

  Future openCamera() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    handleImage(image);
  }

  Future openGallery() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    handleImage(image);
  }

  void handleImage(File image) {
    image != null
        ? Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultPage(image: image)),
          )
        : Toast.show("You didn't select an image!", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.camera, Icons.photo];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: (int tappedIconIndex) {
              if (tappedIconIndex == 0) {
                openCamera();
              } else {
                openGallery();
              }
            },
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Camera',
        backgroundColor: AppColors.PINK,
        foregroundColor: AppColors.PINK,
        child: Icon(Icons.camera),
        elevation: 5.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_navSelectedIndex],
      bottomNavigationBar: BottomNavBar(
        centerItemText: '',
        color: Colors.grey,
        selectedColor: AppColors.AQUA,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (int selectedIndex) {
          setState(() {
            _navSelectedIndex = selectedIndex;
          });
        },
        items: [
          BottomNavBarItem(iconData: Icons.dashboard, text: 'Dashboard'),
          BottomNavBarItem(iconData: Icons.local_hospital, text: 'Clinics'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
    );
  }
}

// return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: new SingleChildScrollView(
//           child: new ListBody(
//             children: <Widget>[
//               GestureDetector(
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   child: Text('Take a picture'),
//                 ),
//                 onTap: openCamera,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//               ),
//               GestureDetector(
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   child: Text('Select from Gallery'),
//                 ),
//                 onTap: openGallery,
//               ),
//             ],
//           ),
//         ),
//       );
//     });
