import 'dart:convert';
import 'package:dust/data/mise.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;

class MiseApi{
  final BASE_URL = "http://apis.data.go.kr";
  final String key= "iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D";

  Future<List<Mise>> getMiseDate(String stationName)async{
    String url = "$BASE_URL/B552584/ArpltnInforInqireSvc/"
        "getMsrstnAcctoRltmMesureD"
        "nsty?"
        "serviceKey=$key&returnT"
        "ype=json&numOfRows=100&pageNo=1&stationName=${Uri.encodeQueryComponent(stationName)}&dataTerm=DAILY&ver=1.0"; //인코딩해줘
    final response = await http.get(Uri.parse(url));

    print(utf8.decode(response.bodyBytes));

    List<Mise> data = [];
    if(response.statusCode == 200){
      String body= utf8.decode(response.bodyBytes);
          var res = json.decode(body) as Map<String,dynamic>;
          for(final _res in res["response"]["body"]["items"]){
            final m = Mise.fromJson(_res as Map<String,dynamic>); //pm10을 int로 변환
            data.add(m);
          }
          return data;
    }else{
      return [];
    }
  }
}