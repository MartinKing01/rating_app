import 'package:flutter/material.dart';
import 'package:rating_app/page_header.dart';
import 'beer_item.dart';
import 'logic.dart';

class BeerList extends StatelessWidget {
  final List<Beer> list;
  final count = 4;
  final ScrollController? controller;

  const BeerList(this.list, {super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ListView.separated(
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return SizedBox(
                  height: constraints.maxHeight / count - count,
                  child: BeerItem(list[i]));
            },
            itemCount: list.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1, thickness: 1,);
            },
          );
        });
  }
}
