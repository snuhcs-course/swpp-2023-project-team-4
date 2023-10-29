import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/app/presentation/vm/stock.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:provider/provider.dart';

import 'search_stock_screen_view_model.dart';

part 'widget/searched_tile.dart';

class SearchStockScreen extends StatelessWidget {
  static const routeName = "/search-stock";

  const SearchStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchStockScreenViewModel(),
      child: Scaffold(
        backgroundColor: BackgroundColor.defaultColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: StrokeColor.writeText,
                    width: 2,
                  ),
                )),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        MyNavigator.pop();
                      },
                      child: Image.asset("assets/images/arrow_back.png", width: 24),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Builder(builder: (context) {
                        return TextFormField(
                          controller: context.read<SearchStockScreenViewModel>().controller,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: "검색어를 입력하세요",
                            hintStyle: OtherTextStyle.button.writeText,
                            border: InputBorder.none,
                          ),
                          cursorColor: StrokeColor.writeText,
                          style: OtherTextStyle.button.writeText,
                        );
                      }),
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer<SearchStockScreenViewModel>(
                  builder: (_, viewModel, __) {
                    return ListView.separated(
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _SearchedTile(
                          key: ValueKey(viewModel.searchedList[index]),
                          stock: viewModel.searchedList[index],
                          searchKeyword: viewModel.controller.text,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 3);
                      },
                      itemCount: viewModel.searchedList.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
