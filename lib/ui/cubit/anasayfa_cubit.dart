import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemekler_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{
  AnasayfaCubit():super(<Yemekler>[]);
  var repo = YemeklerRepository();

  Future<void> yemekleriGetir() async{
    var liste = await repo.tumYemekleriGetir();
    emit(liste);
  }
}