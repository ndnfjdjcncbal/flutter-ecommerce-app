import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/function/checkinternet.dart';
import 'package:http/http.dart' as http;

class crud {
  Future<Either<StatusRequest, Map>> postdata(String linkurl, Map data) async {
    if (await checkinternet() == true) {
      var response = await http.post(Uri.parse(linkurl), body: data);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("RAW BODY: ${response.body}");
        Map responsebode = jsonDecode(response.body);
        print(responsebode);
        print(response.body);
        return Right(responsebode);
      } else {
        return left(StatusRequest.offlinefailure);
      }
    } else {
      return left(StatusRequest.offlinefailure);
    }
  }
}
