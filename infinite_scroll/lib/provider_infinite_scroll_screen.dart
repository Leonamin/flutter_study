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
            body: ListView.builder(
              itemCount: provider.cache.length + 1,
              itemBuilder: (context, index) {
                if (context.read<AjaxProvider>().cache.length == index) {
                  return InkWell(
                    onTap: () {
                      provider.fetchItems(nextId: provider.cache.last + 1);
                    },
                    child: SizedBox(
                      height: 50,
                      child: Center(
                          child: provider.loading
                              ? const CircularProgressIndicator()
                              : const Text("더보기")),
                    ),
                  );
                }
                return ListTile(
                    title: Text(
                  provider.cache[index].toString(),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
