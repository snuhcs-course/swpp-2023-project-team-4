import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_stock/app/presentation/screen/stock_register_screen/stock_register_screen.dart';
import 'package:my_stock/app/presentation/util/my_navigator.dart';
import 'package:my_stock/app/presentation/vm/stock.dart';
import 'package:my_stock/core/theme/color_theme.dart';
import 'package:my_stock/core/theme/text_theme.dart';
import 'package:provider/provider.dart';

import 'search_stock_screen_view_model.dart';

part 'widget/searched_tile.dart';

class SearchStockScreen extends StatefulWidget {
  static const routeName = "/search-stock";

  SearchStockScreen({super.key});

  @override
  State<SearchStockScreen> createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchStockScreenViewModel(),
      child: Scaffold(
        backgroundColor: BackgroundColor.defaultColor,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      MyNavigator.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Image.asset("assets/images/arrow_back.png", width: 24),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        focusNode.requestFocus();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Builder(builder: (context) {
                        return TextFormField(
                          controller: context.read<SearchStockScreenViewModel>().controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: "검색어를 입력하세요",
                            hintStyle: OtherTextStyle.button.writeText,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          cursorColor: StrokeColor.writeText,
                          style: OtherTextStyle.button.writeText,
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: StrokeColor.writeText,
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
