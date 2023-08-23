import 'package:flutter/material.dart';

class favoritePage extends StatefulWidget {
  const favoritePage({super.key});

  @override
  State<favoritePage> createState() => _favoritePageState();
}

class _favoritePageState extends State<favoritePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: SafeArea(
          child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.amber,
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       color: Colors.black,
        //       iconSize: 30,
        //       icon: Icon(Icons.notifications),
        //     ),
        //   ],
        // ),
        body: Container(
            // decoration: BoxDecoration(color: Colors.blueGrey[200]),
            ),
      )),
    );
  }
}
