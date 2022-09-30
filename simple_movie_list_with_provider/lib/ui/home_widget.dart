import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie_list_with_provider/provider/movie_provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
    );
  }
}
