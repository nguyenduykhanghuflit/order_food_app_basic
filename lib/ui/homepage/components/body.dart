import 'package:flutter/material.dart';

import '../../../utilities/utilities.dart';
import 'fragments/account_detail.dart';
import 'fragments/favourite_fragment.dart';
import 'fragments/home_fragment.dart';
import 'fragments/notification_fragment.dart';
import 'homeheader.dart';
import 'menuheader.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var selectIndex = 0;
  var flag = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      //ListWidget
      const HomeDetail(),
      FavouriteDetail(Utilities.data),
      const NotificationDetail(),
      const AccountDetail(),
    ];
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            screen[selectIndex],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectIndex,
      onTap: (value) {
        setState(() {
          selectIndex = value;
          if (selectIndex != 3) {
            flag = true;
          } else {
            flag = false;
          }
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favourite',
        ),
        BottomNavigationBarItem(
          label: 'Notification',
          icon: Icon(Icons.notifications),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: flag ? const HomeHeader() : const MenuHeader(),
    );
  }
}
