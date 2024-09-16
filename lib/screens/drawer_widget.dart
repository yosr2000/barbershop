import 'package:barber_shop/repositories/auth_repo.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            //color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "images/login.png",
                  width: 50,
                  height: 50,
                ),
                Text(
                  AuthRepo().checkUser(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ExpansionTile(title: Text("Home"), children: [
            DrawerItem(
              title: "Home",
              icon: Icons.home,
              path: "/home",
            ),
          ]),
          DrawerItem(
            title: "Reservation",
            icon: Icons.border_color_sharp,
            path: "/reservation",
          ),
          DrawerItem(
            title: "settings",
            icon: Icons.settings,
            path: "/settings",
          ),
          Spacer(),
          DrawerItem(
            title: "Logout",
            icon: Icons.logout_outlined,
            path: "/logout",
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.path,
  });
  final String title;
  final IconData icon;
  final String path;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.pushNamed(context, path);
      },
    );
  }
}
