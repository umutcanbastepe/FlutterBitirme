import 'package:bitirme_projesi/data/entity/sepet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/yemekler_repository.dart';
class SepetSayfaCubit extends Cubit<List<Sepet>>{
  SepetSayfaCubit():super(<Sepet>[]);
  var repo = YemeklerRepository();

  Future<void> sepetiGetir() async{
    var liste = await repo.sepettekiYemekleriGetir("umutcan_bastepe");
    emit(liste);
  }
  Future<void> guncelleme(Sepet sepettekiYemek,String yemekAdet) async{
    await repo.guncelle(sepettekiYemek,yemekAdet);
    await sepetiGetir();
  }
  Future<void> sil(String sepet_yemek_id) async{
    await repo.sil(sepet_yemek_id);
    await sepetiGetir();
  }
}