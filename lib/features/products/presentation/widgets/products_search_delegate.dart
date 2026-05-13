import 'package:flutter/material.dart';

class ProductsSearchDelegate extends SearchDelegate {
  final Function(String)? onSearch;

  ProductsSearchDelegate(this.onSearch);

  @override
  Widget buildResults(BuildContext context) {
    onSearch?.call(query);
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () => query = "",
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );
}