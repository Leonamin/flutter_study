import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ajax_provider.dart';

class ProviderInfiniteScrollScreen extends StatefulWidget {
  const ProviderInfiniteScrollScreen({super.key});

  @override
  State<ProviderInfiniteScrollScreen> createState() =>
      _ProviderInfiniteScrollScreenState();
}

class _ProviderInfiniteScrollScreenState
    extends State<ProviderInfiniteScrollScreen> {
  _makeListView(AjaxProvider provider) {
    // 로딩 중이면서 캐시가 없음
    if (provider.loading && provider.cache.isEmpty) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 로딩 아닌데 캐시가 없음
    if (!provider.loading && provider.cache.isEmpty) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: Text("데이따 없음"),
        ),
      );
    }

    return ListView.builder(
        itemCount: provider.cache.length + 1,
        itemBuilder: (context, index) {
          if (index < provider.cache.length) {
            return ListTile(
                title: Text(
              provider.cache[index].toString(),
            ));
          }
          // return InkWell(
          //   onTap: () {
          //     provider.fetchItems(nextId: provider.cache.last + 1);
          //   },
          //   child: SizedBox(
          //     height: 50,
          //     child: Center(
          //         child: provider.loading
          //             ? const CircularProgressIndicator()
          //             : const Text("더보기")),
          //   ),
          // );

          if (!provider.loading) {
            // 이게 원리가 뭘까?
            // UI가 생성되는 시점은 스크롤로 내려서 가까워지면 생성이 되는거 같다.
            Future.microtask(() {
              provider.fetchItems(nextId: index);
            });
          }

          return CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = AjaxProvider();
        provider.fetchItems();
        return provider;
      },
      // 왜 이거는 빌드가 안됨?
      // builder: (context, child) {
      //   print(context.read<AjaxProvider>().cache);
      //   return Scaffold(
      //     appBar: AppBar(title: Text("무한 스크롤 테스트")),
      //     body: ListView.builder(
      //       itemCount: context.read<AjaxProvider>().cache.length,
      //       itemBuilder: (context, index) => ListTile(
      //         title: Text(
      //           context.read<AjaxProvider>().cache[index].toString(),
      //         ),
      //       ),
      //     ),
      //     floatingActionButton: FloatingActionButton(
      //       onPressed: () {
      //         context
      //             .read<AjaxProvider>()
      //             .fetchItems(nextId: context.read<AjaxProvider>().cache.last);
      //       },
      //     ),
      //   );
      // },
      child: Consumer<AjaxProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("무한 스크롤 테스트")),
            body: _makeListView(provider),
          );
        },
      ),
    );
  }
}
