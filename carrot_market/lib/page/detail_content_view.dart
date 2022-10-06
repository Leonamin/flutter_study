import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;
  DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  late Size deviceSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initState에서는 context 접근이 안되므로 여기서 가져온다
    deviceSize = MediaQuery.of(context).size;
  }

  // return Type이 Widget이면 PreferredSizeWidget이 필요하다고 나옴
  AppBar _makeAppBarWidget() {
    return AppBar(
      // 투명 처리
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            )),
      ],
    );
  }

  Widget _makeBody() {
    return Container(
      child: Hero(
        tag: widget.data['cid']!,
        child: Image.asset(
          widget.data['image']!,
          width: deviceSize.width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 이거 true로 주면 앱바 겹치는 효과 발생
      extendBodyBehindAppBar: true,
      appBar: _makeAppBarWidget(),
      body: _makeBody(),
    );
  }
}
