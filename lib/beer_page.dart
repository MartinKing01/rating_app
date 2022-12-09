import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rating_app/page_header.dart';
import 'package:rating_app/repo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'logic.dart';
import 'main.dart';

class BeerPage extends StatefulWidget {
  final Beer beer;

  const BeerPage({super.key, required this.beer});

  @override
  _BeerPageState createState() {
    return _BeerPageState();
  }
}

class _BeerPageState extends State<BeerPage> {
  final repository = ListRepository();
  Future<List<Beer>>? listRequest;

  @override
  void initState() {
    listRequest = repository.getBeers([1]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 12,
                  child: BeerHeader(
                      name: widget.beer.name,
                      imageURL: widget.beer.imageURL ?? "")),
              Expanded(
                flex: 16,
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  heightFactor: 0.9,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 4, child: DescriptionBlock(beer: widget.beer)),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 2, child: RatingBlock(beerId: widget.beer.id)),
            ],
          )),
    );
  }
}

class RatingBlock extends StatefulWidget {
  final int? beerId;

  const RatingBlock({
    Key? key,
    required this.beerId,
  }) : super(key: key);

  @override
  State<RatingBlock> createState() => _RatingBlockState();
}

class _RatingBlockState extends State<RatingBlock> {
  int rating = 0;

  DocumentReference getReference() {
    return db.collection("beers").doc(widget.beerId.toString());
  }

  Future<int> getRating() async {
    var reference = getReference();
    return reference.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          var docMap = (doc.data() as Map<String, dynamic>);
          return docMap["rating"];
        }
        return 0;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  void voteBeer(bool up) async {
    var rating = getRating();
    var updatedRating = (await rating) + ((up == true) ? 1 : -1);
    var reference = getReference();
    var doc = {"rating": updatedRating};
    reference.set(doc, SetOptions(merge: true));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide())),
      child: FractionallySizedBox(
        alignment: Alignment.center,
        heightFactor: 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 4,
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    AppLocalizations.of(context)!.rateTheBeer,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 10,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: IconButton(
                          icon: SvgPicture.asset("assets/arrow_down_icon.svg"),
                          onPressed: () {
                            voteBeer(false);
                          },
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: FittedBox(
                        fit: BoxFit.contain,
                        child: FutureBuilder(
                            future: getRating(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data.toString());
                              } else if (snapshot.hasError) {
                                return const Text("Error");
                              } else {
                                return const CircularProgressIndicator();
                              }
                            })),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: IconButton(
                          icon: SvgPicture.asset("assets/arrow_up_icon.svg"),
                          onPressed: () {
                            voteBeer(true);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ValueBlock extends StatelessWidget {
  final String name;
  final String value;

  const ValueBlock({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ))),
        Expanded(
            flex: 4,
            child: FittedBox(
                fit: BoxFit.contain,
                child: AutoSizeText(value,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor))))
      ],
    );
  }
}

class DescriptionBlock extends StatelessWidget {
  final Beer beer;

  const DescriptionBlock({super.key, required this.beer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: FittedBox(
            alignment: Alignment.bottomLeft,
            fit: BoxFit.contain,
            child: Text(
              beer.tagline,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: AutoSizeText(
            beer.description,
            minFontSize: 1,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Flexible(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ValueBlock(
                  name: 'abv',
                  value: '${beer.abv}%',
                ),
              ),
              Spacer(flex: 1),
              Expanded(
                  flex: 2,
                  child: ValueBlock(
                    name: 'ibu',
                    value: '${beer.ibu}',
                  )),
              Spacer(key: key, flex: 4)
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.contain,
                    child: Text(
                      AppLocalizations.of(context)!.ingredients,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: AutoSizeText(
            beer.ingredients.toString(),
            minFontSize: 1,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class BeerHeader extends StatelessWidget {
  final String imageURL;
  final String name;

  const BeerHeader({super.key, required this.imageURL, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Column(
        children: const [
          Expanded(
            flex: 6,
            child: PageHeader(),
          ),
          Spacer(
            flex: 2,
          )
        ],
      ),
      Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(flex: 1),
                      Flexible(
                          flex: 15,
                          child: IconButton(
                            icon: SvgPicture.asset("assets/arrow_page_back_icon.svg"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 1,
                        child: AutoSizeText(
                          name,
                          minFontSize: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 400,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
                Expanded(flex: 4, child: Image.network(imageURL))
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
