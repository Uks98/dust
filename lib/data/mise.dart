

class Mise{
  int pm10;
  int pm25;
  int khai;
  String dataTime;
  //double? so;
  //double? co;
  //double? no;
  //double? o3;

  Mise({required this.pm10,required this.pm25,required this.khai,required this.dataTime,});

  //미세 데이터를 받아서 실제 객체로 만드는 factory
  factory Mise.fromJson(Map<String,dynamic>data){
      return Mise(
        pm10: int.tryParse(data["pm10Value"] ?? "") ?? 0, //try.parse == 데이터 안에 값이 없으면 ""으로 반환해줘요
        pm25: int.tryParse(data["pm25Value"] ?? "") ?? 0,
        khai: int.tryParse(data["khaiGrade"] ?? "") ?? 0,
        dataTime: data["dataTime"] ?? "",
      );
  }
}