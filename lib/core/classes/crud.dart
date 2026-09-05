import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/function/checkinternet.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;

class crud {
  Future<Either<StatusRequest, Map>> postdata(String linkurl, Map data) async {
    if (await checkinternet() == true) {
      var response = await http.post(Uri.parse(linkurl), body: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebode = jsonDecode(response.body);
        return Right(responsebode);
      } else {
        if (response.statusCode == 400 || response.statusCode == 404) {
          return left(StatusRequest.serverfailure);
        }
        return left(StatusRequest.serverfailure);
      }
    } else {
      Get.snackbar("No Internet", "Please Connect Internet");
      return left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> postdataWithFile(
    String linkurl,
    Map<String, String> data,
    String fileFieldName,
    String filePath,
  ) async {
    if (await checkinternet() == true) {
      try {
        var request = http.MultipartRequest('POST', Uri.parse(linkurl));

        request.fields.addAll(data);

        request.files.add(
          await http.MultipartFile.fromPath(fileFieldName, filePath),
        );

        var response = await request.send();
        var responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map result = jsonDecode(responseBody);
          return Right(result);
        } else {
          return left(StatusRequest.serverfailure);
        }
      } catch (e) {
        return left(StatusRequest.serverfailure);
      }
    } else {
      Get.snackbar("No Internet", "Please Connect Internet");
      return left(StatusRequest.offlinefailure);
    }
  }
}
