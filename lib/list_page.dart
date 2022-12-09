import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rating_app/beer_list.dart';
import 'package:rating_app/main.dart';
import 'package:rating_app/page_header.dart';
import 'package:rating_app/repo.dart';
import 'package:rating_app/top_page.dart';
import 'package:flutter/services.dart';

import 'beer_item.dart';
import 'chip_list.dart';
import 'error_message.dart';
import 'logic.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() {
    return _ListPageState();
  }
}

class _ListPageState extends State<ListPage> {
  final repository = ListRepository();
  List<Beer> list = [];

  final List<String> filters = const ['IPA', 'Pilsner', 'Hoppy', 'Ale'];
  String? selectedFilter;
  int maxPage = 1;
  final int perPage = 10;
  bool loading = false;

  void scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !loading) {
      loadMaxPage();
    }
  }

  @override
  void initState() {
    loadMaxPage();
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  Future<void> loadPage(int page) async {
    var request = repository.getBeerPage(page, perPage, filter: selectedFilter);
    loading = true;
    var newBeers = await request;
    loading = false;
    list.addAll(newBeers);
    _streamController.add(newBeers);
  }

  Future<void> loadFirstPage() async {
    list.clear();
    maxPage = 1;
    loadPage(1);
  }

  Future<void> loadMaxPage() async {
    loadPage(maxPage);
    maxPage++;
  }

  final StreamController<List<Beer>> _streamController =
      StreamController<List<Beer>>();

  StreamSink<List<Beer>> get itemsSink => _streamController.sink;

  Stream<List<Beer>> get itemsStream => _streamController.stream;
  final ScrollController _scrollController = ScrollController();

  TopButton worstButton() => TopButton(
        text: 'See 5 worst beers',
        style: ElevatedButton.styleFrom(
            side: const BorderSide(color: Colors.black),
            backgroundColor: Colors.white),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TopPage(
              title: 'Worst beers',
              ascending: false,
              button: bestButton(),
            ),
          ));
        },
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 400, color: Colors.black),
      );

  TopButton bestButton() => TopButton(
        text: 'See 5 best beers',
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TopPage(
              title: 'Best beers',
              ascending: true,
              button: worstButton(),
            ),
          ));
        },
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 400, color: Colors.black),
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: loadFirstPage,
          child: StreamBuilder<List<Beer>>(
              stream: itemsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const Expanded(
                            flex: 4,
                            child: NameIconPageHeader(
                              title: "List of beers",
                              iconPath: "assets/beer_icon.svg",
                            )),
                        Expanded(
                            flex: 2,
                            child: FractionallySizedBox(
                                heightFactor: 0.8,
                                alignment: Alignment.center,
                                child: ChipList(
                                  filters: filters,
                                  update: (int? selected) => {
                                    selectedFilter = selected != null
                                        ? filters[selected]
                                        : null,
                                    loadFirstPage()
                                  },
                                ))),
                        Expanded(
                            flex: 20,
                            child:
                                BeerList(list, controller: _scrollController)),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              Expanded(child: worstButton()),
                              Expanded(child: bestButton()),
                            ],
                          ),
                        ),
                        const Spacer(flex: 1)
                      ],
                    );
                  } else {
                    return Center(
                        child: ErrorMessage(
                      data: snapshot.error.toString(),
                    ));
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }
}

class TopButton extends StatelessWidget {
  final ButtonStyle style;
  final String text;
  final TextStyle? textStyle;
  final Function onPressed;

  const TopButton({
    Key? key,
    required this.style,
    required this.text,
    required this.onPressed,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.8,
        widthFactor: 0.9,
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: style,
                onPressed: () => onPressed(),
                child: FractionallySizedBox(
                    heightFactor: 0.4,
                    child: AutoSizeText(
                      text,
                      minFontSize: 1,
                      style: textStyle,
                    )))));
  }
}

class NameIconPageHeader extends StatelessWidget {
  final String title;
  final String iconPath;

  const NameIconPageHeader({
    Key? key,
    required this.title,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      child: Column(
        children: [
          const Spacer(flex: 1),
          Flexible(
            flex: 2,
            child: FractionallySizedBox(
              heightFactor: 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: AutoSizeText('$title ', style: TextStyle(fontSize: 400, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  Flexible(child: SvgPicture.asset(iconPath))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
