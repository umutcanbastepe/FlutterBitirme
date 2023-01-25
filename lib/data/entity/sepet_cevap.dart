import 'package:bitirme_projesi/data/entity/sepet.dart';

class SepetCevap{
  int success;
  List <Sepet> sepet;

  SepetCevap({required this.success, required this.sepet});
  factory SepetCevap.fromJson(Map<String,dynamic> json){
    var jsonArray = json["sepet_yemekler"] as List;
    var sepet_yemekler = jsonArray.map((jsonArrayNesnesi) => Sepet.fromJson(jsonArrayNesnesi)).toList();
    return SepetCevap(
        sepet: sepet_yemekler,
        success: json ["success"] as int
    );
  }
}