import 'package:json_annotation/json_annotation.dart';

part 'logic.g.dart';

List<Beer> beerListFromJson(List<dynamic> json) =>
    (json).map((e) => Beer.fromJson(e as Map<String, dynamic>)).toList();

List<dynamic> beerListToJson(List<Beer> instance) => instance;

@JsonSerializable()
class Beer {
  final int id;
  final String name;
  final String tagline;
  @JsonKey(name: "image_url")
  final String? imageURL;
  @JsonKey(name: "first_brewed")
  final String firstBrewed;
  final String description;
  final double abv;
  final double? ibu;
  final Ingredients ingredients;

  Beer(this.name, this.tagline, this.firstBrewed, this.description, this.abv,
      this.ibu, this.ingredients, this.imageURL, this.id);

  dynamic toJson() => _$BeerToJson(this);

  factory Beer.fromJson(Map<String, dynamic> obj) => _$BeerFromJson(obj);
}

@JsonSerializable()
class Ingredients {
  final List<Malt> malt;
  final List<Hops> hops;
  final String? yeast;

  Ingredients(this.malt, this.hops, this.yeast);

  dynamic toJson() => _$IngredientsToJson(this);

  factory Ingredients.fromJson(Map<String, dynamic> obj) =>
      _$IngredientsFromJson(obj);

  @override
  String toString() {
    return '${malt.map((e) => e.toString()).join(', ')}, ${hops.map((e) => e.toString()).join(', ')}, $yeast';
  }
}


@JsonSerializable()
class Malt {
  final String name;
  final Amount amount;

  Malt(this.name, this.amount);

  dynamic toJson() => _$MaltToJson(this);

  factory Malt.fromJson(Map<String, dynamic> obj) =>
      _$MaltFromJson(obj);

  @override
  String toString() {
    // TODO: implement toString
    return '$name (${amount.toString()})';
  }
}

@JsonSerializable()
class Hops {
  final String name;
  final Amount amount;
  final String add;
  final String attribute;

  Hops(this.name, this.amount, this.add, this.attribute);

  dynamic toJson() => _$HopsToJson(this);

  factory Hops.fromJson(Map<String, dynamic> obj) =>
      _$HopsFromJson(obj);

  @override
  String toString() {
    // TODO: implement toString
    return '$name (${amount.toString()})';
  }
}

@JsonSerializable()
class Amount {
  final double value;
  final String unit;

  Amount(this.value, this.unit);

  dynamic toJson() => _$AmountToJson(this);

  factory Amount.fromJson(Map<String, dynamic> obj) => _$AmountFromJson(obj);

  @override
  String toString() {
    // TODO: implement toString
    return '$value $unit';
  }
}
