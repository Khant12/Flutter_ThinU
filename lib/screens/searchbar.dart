import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/categorymodel.dart';
import 'package:flutter_app/screens/course_cat_detail.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const historyLength = 5;

  final List<String> _searchHistory = [];
  List<CategoryModel> categories = [];

  List<String>? filteredSearchHistory;

  String? selectedTerm;

  List<String> filterSearchTerms({
    @required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  FloatingSearchBarController? controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  Future<List<CategoryModel>> _loadCategories() async {
    final jsonString = await rootBundle.loadString('assets/courses.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CategoryModel>>(
        future: _loadCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            categories = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: FloatingSearchBar(
                controller: controller,
                body: SearchResultsListView(
                  key: ValueKey(selectedTerm),
                  searchTerm: selectedTerm,
                  categories: categories,
                  onTap: (result) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseCatDetail(
                          selectedCategory: result,
                        ),
                      ),
                    );
                  },
                ),
                transition: SlideFadeFloatingSearchBarTransition(),
                physics: const BouncingScrollPhysics(),
                title: Text(
                  selectedTerm ?? 'Search Categories...',
                  style: Theme.of(context).textTheme.headline6,
                ),
                hint: 'Search and find out...',
                actions: [
                  FloatingSearchBarAction.searchToClear(),
                ],
                onQueryChanged: (query) {
                  filteredSearchHistory = filterSearchTerms(filter: query);
                },
                onSubmitted: (query) {
                  setState(() {
                    addSearchTerm(query);
                    selectedTerm = query;
                  });
                  controller!.close();
                },
                builder: (context, transition) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Colors.white,
                      elevation: 4,
                      child: Builder(
                        builder: (context) {
                          if (filteredSearchHistory!.isEmpty &&
                              controller!.query.isEmpty) {
                            return Container(
                              height: 56,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                'Start searching',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            );
                          } else if (filteredSearchHistory!.isEmpty) {
                            return ListTile(
                              title: Text(controller!.query),
                              leading: const Icon(Icons.search),
                              onTap: () {
                                setState(() {
                                  addSearchTerm(controller!.query);
                                  selectedTerm = controller!.query;
                                });
                                controller!.close();
                              },
                            );
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: filteredSearchHistory!
                                  .map(
                                    (term) => ListTile(
                                      title: Text(
                                        term,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      leading: const Icon(Icons.history),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            deleteSearchTerm(term);
                                          });
                                        },
                                      ),
                                      onTap: () {
                                        setState(() {
                                          putSearchTermFirst(term);
                                          selectedTerm = term;
                                        });
                                        controller?.close();
                                      },
                                    ),
                                  )
                                  .toList(),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final String? searchTerm;
  final List<CategoryModel> categories;
  final Function(String)? onTap;

  const SearchResultsListView({
    required Key key,
    required this.searchTerm,
    required this.categories,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Start searching',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      );
    }

    final filteredCategories = categories
        .where((category) =>
            category.title.toLowerCase().contains(searchTerm!.toLowerCase()))
        .toList();

    return filteredCategories.isNotEmpty
        ? ListView(
            padding: const EdgeInsets.only(top: 80),
            children: List.generate(
              filteredCategories.length,
              (index) => ListTile(
                title: Text(filteredCategories[index].title),
                leading: Container(
                    height: 50,
                    width: 50,
                    child: Image.network(filteredCategories[index].urlImage)),
                onTap: () {
                  if (onTap != null) {
                    onTap!(filteredCategories[index].title);
                  }
                },
              ),
            ),
          )
        : Center(
            child: Text(
              'Not Found',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
  }
}
