import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AjaxProvider extends ChangeNotifier {
  List<int> cache = [];

  // 로딩
  bool loading = false;
  // 아이템 더 있나
  bool hasMore = true;

  _makeRequest({
    required int? nextId,
  }) async {
    if (nextId == null) {
      return;
    }

    await Future.delayed(const Duration(seconds: 1));

    //nextId 다음 20개의 값 가져오기
    return List.generate(20, (index) => nextId + index);
  }

  fetchItems({int? nextId}) async {
    loading = true;
    notifyListeners();

    final items = await _makeRequest(nextId: nextId ?? 0);

    cache = cache + items;

    loading = false;
    notifyListeners();
  }
}
