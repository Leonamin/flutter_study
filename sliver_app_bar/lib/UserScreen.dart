import 'package:flutter/material.dart';
import 'package:sliver_app_bar/tab_bar_delegate.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  ScrollController? _mainScrollController;
  ScrollController? _postingTabScrollController;
  ScrollController? _commentTabScrollController;

  TabController? _tabController;
  bool lastStatus = true;
  double appBarHeight = 275;

  // 테스트용 코드 Provider로 나중에 대체해야함
  List<int> cachePosting = [];
  List<int> cacheComment = [];

  // 로딩
  bool loadingPosting = false;
  bool loadingComment = false;

  // 아이템 더 있나
  bool hasMorePosting = true;
  bool hasMoreComment = true;

  // 맨 아래로 스크롤 시 자동 요청 횟수
  final autoRequestCount = 3;

  int requestCount = 0;

  _makeRequest({
    required int? nextId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    //nextId 다음 20개의 값 가져오기
    return List.generate(20, (index) => (nextId ?? 0) + index);
  }

  fetchPostings({int? nextId}) async {
    setState(() {
      loadingPosting = true;
    });

    final List<int> items = await _makeRequest(nextId: nextId ?? 0);

    setState(() {
      cachePosting.addAll(items);
      loadingPosting = false;
    });
  }

  fetchComments({int? nextId}) async {
    setState(() {
      loadingComment = true;
    });

    final List<int> items = await _makeRequest(nextId: nextId ?? 0);

    setState(() {
      cacheComment.addAll(items);
      loadingComment = false;
    });
  }

  // 여기까지 임시 테스트 요청 코드

  bool get _isShrink {
    return _mainScrollController != null &&
        _mainScrollController!.hasClients &&
        _mainScrollController!.offset > (appBarHeight - kToolbarHeight);
  }

  void _mainScrollListener() {
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
    _mainScrollController = ScrollController()
      ..addListener(_mainScrollListener);
    _postingTabScrollController = ScrollController();
    _commentTabScrollController = ScrollController();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchPostings();
    fetchComments();
  }

  @override
  void dispose() {
    _mainScrollController?.removeListener(_mainScrollListener);
    _mainScrollController?.dispose();
    _postingTabScrollController?.dispose();
    _commentTabScrollController?.dispose();
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

  _requestButton(fetchItem, isLoading) {
    return InkWell(
      onTap: fetchItem,
      child: SizedBox(
        height: 50,
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text("더보기")),
      ),
    );
  }

  _makeListView(controller, key, List cache, isLoading,
      Function({required int nextId}) fetchItem) {
    // 로딩 중이면서 캐시가 없음
    if (isLoading && cache.isEmpty) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 로딩 아닌데 캐시가 없음
    if (!isLoading && cache.isEmpty) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: Text("데이따 없음"),
        ),
      );
    }

    return ListView.separated(
      key: PageStorageKey(key),
      controller: controller,
      // +1 인 이유는 맨 마지막에 로딩 또는 더보기 버튼을 두기 위해서임
      itemCount: cache.length + 1,
      itemBuilder: (context, index) {
        if (index < cache.length) {
          // TODO 여기 PostingItem과 ChildItem을 구분할 방법이 없어서 공통사용이 힘들 수도 있음
          return ListTile(
              title: Text(
            cache[index].toString(),
          ));
        }
        // if (requestCount < autoRequestCount) {
        if (true) {
          if (!isLoading) {
            // UI가 생성되는 시점은 스크롤로 내려서 가까워지면 생성이 되는거 같다.
            Future.microtask(() {
              fetchItem(nextId: index);
            });
            requestCount++;
          }
          return CircularProgressIndicator();
        } else {
          return _requestButton(fetchItem(nextId: index), isLoading);
        }
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  _makeSliverListWidget(controller, PageStorageKey<String> key, List cache,
      isLoading, Function({required int nextId}) fetchItem) {
    // 로딩 중이면서 캐시가 없음
    if (isLoading && cache.isEmpty) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 로딩 아닌데 캐시가 없음
    if (!isLoading && cache.isEmpty) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: Text("데이따 없음"),
        ),
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
          return CustomScrollView(
            key: key,
            // controller: controller,
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                childCount: cache.length + 1,
                (context, index) {
                  if (index < cache.length) {
                    // TODO 여기 PostingItem과 ChildItem을 구분할 방법이 없어서 공통사용이 힘들 수도 있음
                    return ListTile(
                        title: Text(
                      cache[index].toString(),
                    ));
                  }
                  // if (requestCount < autoRequestCount) {
                  if (true) {
                    if (!isLoading) {
                      // UI가 생성되는 시점은 스크롤로 내려서 가까워지면 생성이 되는거 같다.
                      Future.microtask(() {
                        fetchItem(nextId: index);
                      });
                      requestCount++;
                    }
                    return const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return _requestButton(fetchItem(nextId: index), isLoading);
                  }
                },
              ))
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: _mainScrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _appBar(),
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: _tabBar(),
              ),
            ];
          },
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              _makeSliverListWidget(
                  _postingTabScrollController,
                  PageStorageKey<String>("1"),
                  cachePosting,
                  loadingPosting,
                  fetchPostings),
              _makeSliverListWidget(
                  _commentTabScrollController,
                  PageStorageKey<String>("2"),
                  cacheComment,
                  loadingComment,
                  fetchComments),
            ],
          )),
    );
  }
}
