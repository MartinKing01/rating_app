import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  TopPage({super.key,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 30,
                child: NameIconPageHeader(
                  title: title,
                  iconPath: "assets/beer_icon.svg",
                )),
            Flexible(
                flex: 60,
                child: FutureBuilder(
                    future: getTopN(5, ascending),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return BeerList((snapshot.data as List<Beer>));
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text("ANADSADSADSA");
                      } else {
                        return CircularProgressIndicator();
                      }
                    })),
            Expanded(flex: 10, child: button),
            Spacer(flex: 5)
          ],
        ));
  }
}
