import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rating_app/beer_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'logic.dart';

class BeerItem extends StatelessWidget {
  final Beer beer;

  const BeerItem(this.beer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FractionallySizedBox(
        heightFactor: 0.8,
        widthFactor: 0.9,
        child: Row(
          children: [
            Expanded(flex: 4, child: BeerImage(imageURL: beer.imageURL ?? '')),
            Expanded(
                flex: 8,
                child: BeerDescription(
                  name: beer.name,
                  tagline: beer.tagline,
                  abv: beer.abv,
                  beer: beer,
                )),
          ],
        ),
      ),
    );
  }
}

class BeerImage extends StatelessWidget {
  final String imageURL;

  const BeerImage({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      child: FractionallySizedBox(
          heightFactor: 0.85, child: Image.network(imageURL)),
    );
  }
}

class BeerDescription extends StatelessWidget {
  final String name;
  final String tagline;
  final double abv;
  final Beer beer;

  const BeerDescription(
      {super.key,
      required this.name,
      required this.tagline,
      required this.abv,
      required this.beer});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 4,
              child: FitHeightText(name, fontWeight: FontWeight.bold),
            ),
            Expanded(
                flex: 3,
                child: FitHeightText(
                  tagline,
                )),
            Expanded(
                flex: 3,
                child: FitHeightText(
                  '$abv%',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                )),
            Expanded(
              flex: 4,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BeerPage(beer: beer),
                      ),
                    );
                  },
                  child: FractionallySizedBox(
                      heightFactor: 0.5,
                      child: FitHeightText(
                        AppLocalizations.of(context)!.moreInfo,
                        textAlign: TextAlign.center,
                      ))),
            ),
          ]),
    );
  }
}

class FitHeightText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color? color;

  const FitHeightText(this.text,
      {super.key, this.textAlign, this.fontWeight, this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return AutoSizeText(text,
            textAlign: textAlign,
            minFontSize: 1,
            style:
                TextStyle(fontSize: 400, fontWeight: fontWeight, color: color));
      },
    );
  }
}
