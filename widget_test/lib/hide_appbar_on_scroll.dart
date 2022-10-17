import 'package:flutter/material.dart';

class HideAppBarOnScroll extends StatefulWidget {
  const HideAppBarOnScroll({super.key});

  @override
  State<HideAppBarOnScroll> createState() => _HideAppBarOnScrollState();
}

class _HideAppBarOnScrollState extends State<HideAppBarOnScroll>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Hide appbar on scroll'),
              // pinned: true,    // true 앱바 최소 크기가 남아있음 false 앱바가 완전히 사라짐
              expandedHeight: 250.0,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              // bottom: TabBar(
              //   tabs: <Tab>[
              //     Tab(text: 'A'),
              //     Tab(text: 'B'),
              //   ],
              //   controller: _tabController,
              // ),
            ),
          ];
        },
        // body: TabBarView(
        //   controller: _tabController,
        //   children: <Widget>[
        //     Container(
        //       color: Colors.amber,
        //     ),
        //     Container(
        //       color: Colors.blue,
        //     ),
        //   ],
        // ),
        body: Container(),
      ),
    );
  }
}
