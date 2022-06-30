import 'package:flutter/material.dart';
import 'package:tryfirestore/ProfilePage.dart';
import 'package:tryfirestore/upload_image.dart';

import 'fetchDB.dart';

class navigationBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => navigationBarState();
}

class navigationBarState extends State<navigationBar>{
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[fetchDB(), UploadImage(),ProfilePage()
    // const Center(
    //   child: Icon(
    //     Icons.camera,
    //     size: 150,
    //   ),
    // ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_open_sharp),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

}
