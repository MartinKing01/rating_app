import 'package:flutter/material.dart';
import 'package:rating_app/page_header.dart';
import 'beer_item.dart';
import 'logic.dart';

class BeerList extends StatelessWidget {
  final List<Beer> list;
  final count = 4;
  final ScrollController? controller;
  final bool topWidget;

  const BeerList(this.list,
      {super.key, this.controller, this.topWidget = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return ListView.separated(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return Stack(alignment: Alignment.center, children: [
            SizedBox(
                height: constraints.maxHeight / count - count,
                child: Stack(alignment: Alignment.center, children: [
                  BeerItem(list[i]),
                  if (topWidget)
                    Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FractionallySizedBox(
                                heightFactor: 0.9,
                                widthFactor: 0.9,
                                child: Wrap(children: [
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black),
                                      child: Text(
                                        '${i + 1}.',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ])))),
                ])),
          ]);
        },
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
            thickness: 1,
          );
        },
      );
    });
  }
}
