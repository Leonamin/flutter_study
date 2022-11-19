import 'package:flutter/material.dart';
import 'package:sliver_app_bar/my_custom_sliver_appbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  _makeCard(context, String text, widget) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return widget;
            },
          ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        _makeCard(context, "CustomSliver", MyCustomSliverAppBar()),
      ],
    ));
  }
}
