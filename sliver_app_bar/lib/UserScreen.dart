import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? _tabController;
  bool lastStatus = true;
  double appBarHeight = 275;

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (appBarHeight - kToolbarHeight);
  }

  void _scrollListener() {
    print(_scrollController!.offset);

    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  /*
  _tabBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 90,
        maxHeight: 90,
        child: Container(
          color: Colors.green[200],
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                child: Text(
                  'TITLE1',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'TITLE2',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'TITLE3',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
*/

  _userInfoWidget() {
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 48),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            // child: Image.network(
            //   userImage,
            //   fit: BoxFit.cover,
            //   height: 100,
            //   width: 100,
            // ),
            child: Container(
              color: Colors.white,
              child: Icon(Icons.person_outline_outlined, size: 100),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          //user.nickname
          "User nickname",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          //user.email
          "User email",
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          //user.profile.introduce
          "Introduce",
        ),
      ],
    ));
  }

  _shrinkUserInfoWidget() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 12),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Nickname",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              // child: Image.network(
              //   headerImage,
              //   fit: BoxFit.cover,
              //   height: 30,
              //   width: 30,
              // ),
            ),
          ],
        ),
      ),
    ];
  }

  _appBar() {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.grey.shade300,
      pinned: true,
      expandedHeight: appBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        title: _isShrink ? Text("Profile") : null,
        background: _userInfoWidget(),
      ),
      actions: _isShrink ? _shrinkUserInfoWidget() : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [_appBar()];
          },
          body: CustomScrollView(
            scrollBehavior: const ScrollBehavior(),
            slivers: [
              SliverFillRemaining(
                child: Container(
                  color: Colors.amber,
                ),
              ),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //     (BuildContext context, int index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Center(child: Text("Item: $index")),
              //       );
              //     },
              //     childCount: 50,
              //   ),
              // ),
            ],
          )),
    );
  }
}
