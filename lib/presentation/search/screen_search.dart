import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/Domain/core/dbounce/debounce.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/search/widgets/search_idle.dart';
import 'package:netflix/presentation/search/widgets/search_result.dart';

TextEditingController searchController = TextEditingController();
ValueNotifier<bool> searchNotifier = ValueNotifier(true);

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: searchNotifier,
              builder: (context, bool search, _) {
                return CupertinoSearchTextField(
                  controller: searchController,
                  padding: const EdgeInsets.all(15),
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  prefixIcon:
                      const Icon(CupertinoIcons.search, color: Colors.grey),
                  suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill,
                      color: Colors.grey),
                  style: const TextStyle(color: kWhiteColor),
                  onChanged: ((value) {
                    if (value.isNotEmpty) {
                      _debouncer.run(() {
                        BlocProvider.of<SearchBloc>(context)
                            .add(SearchMovie(movieQuery: value));
                        search = false;
                        searchNotifier.value = search;
                      });
                    } else if (searchController.text.isEmpty) {
                      log('value is working ');

                      search = true;
                      searchNotifier.value = search;
                    }
                  }),
                );
              },
            ),
            kHeight,
            ValueListenableBuilder(
              valueListenable: searchNotifier,
              builder: (context, bool search, _) {
                return Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      log(state.idleList.toString());

                      if (searchNotifier.value) {
                        return const SearchIdleWidget();
                      } else if (state.searchResultList.isNotEmpty) {
                        return const SearchResultWidget();
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
