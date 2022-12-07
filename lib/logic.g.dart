// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beer _$BeerFromJson(Map<String, dynamic> json) => Beer(
      json['name'] as String,
      json['tagline'] as String,
      json['first_brewed'] as String,
      json['description'] as String,
      (json['abv'] as num).toDouble(),
      (json['ibu'] as num?)?.toDouble(),
      Ingredients.fromJson(json['ingredients'] as Map<String, dynamic>),
      json['image_url'] as String?,
      json['id'] as int,
    );

Map<String, dynamic> _$BeerToJson(Beer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tagline': instance.tagline,
      'image_url': instance.imageURL,
      'first_brewed': instance.firstBrewed,
      'description': instance.description,
      'abv': instance.abv,
      'ibu': instance.ibu,
      'ingredients': instance.ingredients,
    };

Ingredients _$IngredientsFromJson(Map<String, dynamic> json) => Ingredients(
      (json['malt'] as List<dynamic>)
          .map((e) => Malt.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['hops'] as List<dynamic>)
          .map((e) => Hops.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['yeast'] as String?,
    );

Map<String, dynamic> _$IngredientsToJson(Ingredients instance) =>
    <String, dynamic>{
      'malt': instance.malt,
      'hops': instance.hops,
      'yeast': instance.yeast,
    };

Malt _$MaltFromJson(Map<String, dynamic> json) => Malt(
      json['name'] as String,
      Amount.fromJson(json['amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MaltToJson(Malt instance) => <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
    };

Hops _$HopsFromJson(Map<String, dynamic> json) => Hops(
      json['name'] as String,
      Amount.fromJson(json['amount'] as Map<String, dynamic>),
      json['add'] as String,
      json['attribute'] as String,
    );

Map<String, dynamic> _$HopsToJson(Hops instance) => <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'add': instance.add,
      'attribute': instance.attribute,
    };

Amount _$AmountFromJson(Map<String, dynamic> json) => Amount(
      (json['value'] as num).toDouble(),
      json['unit'] as String,
    );

Map<String, dynamic> _$AmountToJson(Amount instance) => <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
    };
