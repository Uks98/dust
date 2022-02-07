import 'package:dust/data/api.dart';
import 'package:flutter/material.dart';

import 'data/mise.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Color> colors = [Colors.green,Colors.orange,Colors.teal,Colors.redAccent];
  List<String>icon = ["assets/ico-happy.png","assets/ico-sad.png","assets/ico-angry-copy.png","assets/ico-angry.png"];
  List<String>status = ["좋음","보통","나쁨","매우나쁨"];
  List<Mise>data  = [];
  String statusName = "물금읍";

  int getStatus(Mise mise){
  if(mise.pm10 >150){
    return 3;
  }else if(mise.pm10 >80){
    return 2;
  }else if(mise.pm10>30){
    return 1;
  }
    return 0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMiseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: getPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget getPage(){
    if(data.isEmpty){
      return Container();
    }
    int _status = getStatus(data.first);

    return Container(
      color: colors[_status],
      child: Column(
        children: [
          Text("현재위치"),
          Text("${statusName}"),
          Image.asset(icon[_status],fit: BoxFit.contain,),
          Text(status[_status]),
          Text("통합 환경 대기 지수 : ${data.first.khai}"),

        ],
      ),
    );
  }
  void getMiseData()async{
    MiseApi api = MiseApi();
    data = await api.getMiseDate(statusName);
    data.removeWhere((element) => element.pm10 ==0);
    setState(() {
    });
  }
}
