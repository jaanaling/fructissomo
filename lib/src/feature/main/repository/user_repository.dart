import 'package:fructissimo/src/feature/main/model/article.dart';

import '../../../core/utils/json_loader.dart';
import '../model/tree.dart';

class Repository {
  final String tree = 'tree';
  final String treep = 'treep';
  final String article = 'article';

  Future<List<DiaryEntry>> loadArticle() {
    return JsonLoader.loadData<DiaryEntry>(
      article,
      'assets/json/$article.json',
      (json) => DiaryEntry.fromMap(json),
    );
  }

  Future<List<TreeProfile>> loadProfile() {
    return JsonLoader.loadData<TreeProfile>(
      treep,
      'assets/json/$treep.json',
      (json) => TreeProfile.fromMap(json),
    );
  }

  Future<List<TreeType>> load() {
    return JsonLoader.loadData<TreeType>(
      tree,
      'assets/json/$tree.json',
      (json) => TreeType.fromMap(json),
    );
  }

  Future<void> save(TreeProfile item) {
    return JsonLoader.saveData<TreeProfile>(
      treep,
      item,
      () async => await loadProfile(),
      (item) => item.toMap(),
    );
  }

  Future<void> update(TreeProfile updated) async {
    return await JsonLoader.modifyDataList<TreeProfile>(
      treep,
      updated,
      () async => await loadProfile(),
      (item) => item.toMap(),
      (itemList) async {
        final index =
            itemList.indexWhere((element) => element.id == updated.id);
        if (index != -1) {
          itemList[index] = updated;
        }
      },
    );
  }

  Future<void> delete(TreeProfile delete) async {
    return await JsonLoader.removeData<TreeProfile>(
      treep,
      delete,
      () async => await loadProfile(),
      (item) => item.toMap(),
    );
  }
}
