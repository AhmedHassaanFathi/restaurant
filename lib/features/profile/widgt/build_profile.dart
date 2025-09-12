 import 'package:flutter/material.dart';

Widget  buildProfileOptions() {
    return Column(
      children: [
         buildListTile('My Profile', Icons.person_outline),
         buildListTile('My Orders', Icons.shopping_bag_outlined),
         buildListTile('My Favorites', Icons.favorite_border),
         buildListTile('Settings', Icons.settings_outlined),
         buildLogoutTile(),
      ],
    );
  }

  Widget  buildListTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {},
    );
  }

  Widget  buildLogoutTile() {
    return ListTile(
      leading: Icon(Icons.logout, color: Colors.red, size: 28),
      title: Text(
        'Log Out',
        style: TextStyle(color: Colors.red, fontSize: 18),
      ),
      onTap: () {},
    );
  }

