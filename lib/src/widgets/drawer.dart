import 'package:flutter/material.dart';
import 'package:test/src/pages/login.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrawerWidget createState() => _DrawerWidget();
}

class _DrawerWidget extends State<DrawerWidget> {
  Widget _createHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text("Test user"),
      accountEmail: Text("@gmail.com"),
      currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('images/avatar.png')),
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
    );
  }

  Widget _createDrawerItem(
      {String? text,
      IconData? icon,
      IconData? icon2,
      GestureTapCallback? onTap}) {
    return ListTile(
      title: Text(text!,
          style: const TextStyle(
              fontFamily: 'ABeeZee',
              fontStyle: FontStyle.italic,
              fontSize: 18)),
      leading: Icon(icon, size: 22, color: Colors.black),
      trailing: Icon(icon2, size: 15, color: Colors.black),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
              text: 'Sign out',
              icon: Icons.logout,
              icon2: Icons.arrow_forward_ios_rounded,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login())),
            ),
          ],
        ),
      ),
    );
  }
}
