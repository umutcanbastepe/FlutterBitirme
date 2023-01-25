import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/entity/yemekler_cevap.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entity/sepet.dart';
import '../entity/sepet_cevap.dart';
class YemeklerRepository{
  List<Yemekler> parseYemeklerCevap(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }
  List<Sepet> parseSepetCevap(String cevap){
    List<Sepet> bosSepet = [];
    try{
      return SepetCevap.fromJson(json.decode(cevap)).sepet;
    }catch(e){
      return bosSepet;
    }
  }

  Future<List<Yemekler>> tumYemekleriGetir() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }


  Future<List<Sepet>> sepettekiYemekleriGetir(String kullaniciAdi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri = {"kullanici_adi":kullaniciAdi};
    var cevap = await http.post(url,body: veri);
    print("Sepetteki Yemekler Cevap: ${cevap.body}");
    return parseSepetCevap(cevap.body);
  }
  Future<void> ekle(Yemekler yemek,String yemekAdet) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var veri = {
      "yemek_adi":yemek.yemek_adi,
      "yemek_resim_adi":yemek.yemek_resim_adi,
      "yemek_fiyat": yemek.yemek_fiyat,
      "yemek_siparis_adet": yemekAdet,
      "kullanici_adi": "umutcan_bastepe",
    };

    var cevap = await http.post(url,body: veri);
    print("Yemek ekle: ${cevap.body}");
  }
  Future<void> sil(String sepet_yemek_id) async {
    //print("Kişi Sil : $kisi_id");
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri = {"sepet_yemek_id":sepet_yemek_id,"kullanici_adi": "umutcan_bastepe"};
    var cevap = await http.post(url,body: veri);
    print("Yemek sil : ${cevap.body}");
  }
  Future<void> guncelle(Sepet sepettekiYemek,String yemekAdet) async{
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    int sayi = int.parse(yemekAdet);
    int guncelYemekAdet = int.parse(sepettekiYemek.yemek_siparis_adet);
    guncelYemekAdet = guncelYemekAdet + sayi;
    if(guncelYemekAdet<=0){
      guncelYemekAdet = 0;
      sil(sepettekiYemek.sepet_yemek_id);
    }
    else{
      var veri = {
        "yemek_adi":sepettekiYemek.yemek_adi,
        "yemek_resim_adi":sepettekiYemek.yemek_resim_adi,
        "yemek_fiyat": sepettekiYemek.yemek_fiyat,
        "yemek_siparis_adet": guncelYemekAdet.toString(),
        "kullanici_adi": "umutcan_bastepe",
      };
      var cevap = await http.post(url,body: veri);
      sil(sepettekiYemek.sepet_yemek_id);
    }
  }
}