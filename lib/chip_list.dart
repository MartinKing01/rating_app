import 'dart:ui';

import 'package:flutter/material.dart';

class ChipList extends StatefulWidget {
  final List<String> filters;
  final Function update;

  const ChipList({super.key, required this.filters, required this.update});

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  int? selected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            controller: ScrollController(),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return FittedBox(
                fit: BoxFit.contain,
                child: ChoiceChip(
                    label: Text(widget.filters[index]),
                    selected: selected == index,
                    onSelected: (bool value) {
                      setState(() {
                        selected = value ? index : null;

                        widget.update(selected);
                      });
                    }),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 20,
              );
            },
            itemCount: widget.filters.length,
          ),
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}