import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_filmes/app/global/constants.dart';
import 'package:meus_filmes/app/global/widgets/customAppBar.dart';
import 'package:meus_filmes/app/global/widgets/customBottomAppBar.dart';
import 'package:meus_filmes/app/modules/search/controllers/search_controller.dart';
import 'package:meus_filmes/app/modules/search/views/widgets/customListTile.dart';
import 'package:meus_filmes/app/theme/colors.dart';

class SearchPage extends GetView<SearchController> {
  final SearchController _searchController = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomBar(""),
        bottomNavigationBar: CustomBottomAppBar("search"),
        body: Center(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.1,
                decoration: BoxDecoration(gradient: primaryGradient),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        color: Colors.grey[400],
                        child: TextField(
                          onSubmitted: (text) =>
                              _searchController.searchMovie(text),
                          autofocus: true,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Pesquisar',
                              suffixIcon:
                                  Icon(Icons.search, color: primaryColor)),
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _searchController.movies.length,
                      itemBuilder: (context, index) => CustomListTile(
                            title: _searchController.movies[index].title,
                            imageUrl: _searchController
                                        .movies[index].posterPath ==
                                    null
                                ? imgNotFound
                                : imageUrl +
                                    _searchController.movies[index].posterPath,
                            onPressed: () {
                              _searchController.addtoMyList(index);
                            },
                          ));
                }),
              )
            ],
          ),
        ));
  }
}
