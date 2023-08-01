import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String title;
  final Icon? icon;

  const CustomTab({Key? key, required this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Text(
      title,
      style: const TextStyle(fontSize: 17),
    ));
  }
}
