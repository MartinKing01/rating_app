import 'package:rating_app/service.dart';

import 'logic.dart';

class ListRepository {
  var owService = PunkService();

  Future<Beer> getBeer(int id) async {
    var response = await owService.getBeers([id]);
    return response.single;
  }

  Future<List<Beer>> getBeers(List<int> ids) async {
    var response = await owService.getBeers(ids);
    return response;
  }

  Future<List<Beer>> getBeerPage(int page, int beerPerPage, {String? filter}) async {
    var response = await owService.getBeerPage(page, beerPerPage, filter: filter);
    return response;
  }
}