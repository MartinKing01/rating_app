import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rating_app/beer_list.dart';
import 'package:rating_app/list_page.dart';
import 'package:rating_app/repo.dart';

import 'list_page.dart';
import 'logic.dart';
import 'main.dart';

class TopPage extends StatelessWidget {
  final String title;
  final bool ascending;
  final TopButton button;
  List<int> idList = [];

  final repository = ListRepository();

  TopPage(
      {super.key,
      required this.title,
      required this.button,
      required this.ascending});

  CollectionReference getReference() {
    return db.collection("beers");
  }

  Future<List<Beer>> getTopN(int n, bool descending) async {
    var reference = getReference();
    var topN = reference.orderBy("rating", descending: descending).limit(n);
    var idListFuture = topN.get().then((QuerySnapshot snapshot) {
      return snapshot.docs.map((it) => int.parse(it.reference.id));
    }, onError: (e) => print(e));
    var idListData = await idListFuture;
    idList = idListData.toList();
    return repository.getBeers(idList);
  }

  List<Beer> rearrange(List<Beer> list) {
    return [
      for (int id in idList) list.where((element) => element.id == id).single
    ];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
    ));
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
              flex: 4,
              child: NameIconPageHeader(
                title: title,
                iconPath: "assets/beer_icon.svg",
              )),
          Flexible(
              flex: 20,
              child: FutureBuilder(
                  future: getTopN(5, ascending),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var list = rearrange(snapshot.data as List<Beer>);
                      return BeerList(list);
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text("Error loading list of beers");
                    } else {
                      return CircularProgressIndicator();
                    }
                  })),
          Expanded(flex: 2, child: button),
          Spacer(flex: 1)
        ],
      )),
    );
  }
}
