import 'package:flutter/material.dart';
import 'package:sliver_app_bar/ajax_provider.dart';
import 'package:sliver_app_bar/tab_bar_delegate.dart';

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

  _tabBar() {
    return SliverPersistentHeader(
      delegate: TabBarDelegate(tabcontroller: _tabController!, tabs: [
        Tab(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: const Text("게시글"),
          ),
        ),
        Tab(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: const Text("댓글"),
          ),
        ),
      ]),
      pinned: true,
    );
  }

  commentCountToString(int count) {
    if (count >= 100) {
      return "99+";
    } else {
      return count.toString();
    }
  }

  _itemRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "게시글 제목",
            style: TextStyle(color: Colors.black),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                commentCountToString(10),
                maxLines: 1,
              ),
              style: TextButton.styleFrom(
                  minimumSize: Size(60, 60),
                  backgroundColor: Colors.grey.withOpacity(0.2))),
        ],
      ),
    );
  }

  _requestButton() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _appBar(),
              _tabBar(),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomScrollView(
              scrollBehavior: const ScrollBehavior(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      print(index);
                      if (index == 49) {
                        return _itemRow();
                      }
                      return Column(
                        children: [_itemRow(), Divider()],
                      );
                    },
                    childCount: 50,
                  ),
                ),
                // SliverFillRemaining(
                //   // 탭바 뷰 내부에는 스크롤이 되는 위젯이 들어옴.
                //   hasScrollBody: true,
                //   child: TabBarView(
                //     controller: _tabController,
                //     children: [
                //       Container(
                //         color: Colors.amber,
                //       ),
                //       Container(
                //         color: Colors.redAccent,
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          )),
    );
  }
}
