import 'package:flutter/material.dart';

//https://stackoverflow.com/questions/71470499/custom-sliver-app-bar-in-flutter-with-an-image-and-2-text-widgets-going-into-app

class MyCustomSliverAppBar extends StatefulWidget {
  const MyCustomSliverAppBar({super.key});

  @override
  State<MyCustomSliverAppBar> createState() => _MyCustomSliverAppBarState();
}

class _MyCustomSliverAppBarState extends State<MyCustomSliverAppBar> {
  ScrollController? _scrollController;
  bool lastStatus = true; // 이건 쓸곳은 없는거 같고 단순 이전 상태 보관용으로 보인다.
  double height = 275; //
  final headerImage = 'https://picsum.photos/250?image=9';

  void _scrollListener() {
    print(_scrollController!.offset);

    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  // _isShirnk를 이용해서 배경과 앱바를 구분한다.
  // 아래 연산은 딱 AppBar 위치에서 shrink를 구분하기위한 연산이다
  // offset이 0일 경우 SliverAppBar가 최대로 펼쳐지는 크기가 되며
  // offset이 height일 경우 SliverAppBar와 다 sliver간의 경계점이다.
  // offset이 height - kToolbarHeight일 경우 그 때부터 앱바 최소화 크기시작점이 된다.
  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  _background(textTheme) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                headerImage,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Flipkart",
            style: textTheme.headline4,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "flipkart.com",
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Info about the company",
          ),
        ],
      ),
    );
  }

  _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // 이부분은 기본 위젯
          const UserAccountsDrawerHeader(
            accountName: Text("Zakaria Hossain"),
            accountEmail: Text("zakariaaltime@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  _appBar(textTheme) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.blueGrey,
      pinned: true,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          title: _isShrink
              ? const Text(
                  "Profile",
                )
              : null,
          background: _background(textTheme)),
      actions: _isShrink
          ? [
              Container(
                width: 50,
                height: 50,
                color: Colors.amber,
              ),
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
                            "Flipkart",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "flipkart.com",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        headerImage,
                        fit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Horizons Weather',
      home: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [_appBar(textTheme)];
          },
          body: CustomScrollView(
            scrollBehavior: const ScrollBehavior(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Item: $index")),
                    );
                  },
                  childCount: 50,
                ),
              ),
            ],
          ),
        ),
        drawer: _drawer(),
      ),
    );
  }
}
