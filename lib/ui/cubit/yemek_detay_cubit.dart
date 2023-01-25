import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/yemekler.dart';
import '../../data/repo/yemekler_repository.dart';

class YemekDetayCubit extends Cubit<void>{
  YemekDetayCubit():super(0);
  var repo = YemeklerRepository();
  Future<void> increase(Yemekler yemek,String yemekAdet) async{
    await repo.ekle(yemek,yemekAdet);
  }
}