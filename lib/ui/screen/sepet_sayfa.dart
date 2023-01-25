import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/sepet.dart';
import '../cubit/sepet_sayfa_cubit.dart';
class SepetSayfa extends StatefulWidget {
  const SepetSayfa({Key? key}) : super(key: key);

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  int fiyat = 0;
  String text = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fiyat = 0;
    context.read<SepetSayfaCubit>().sepetiGetir();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async{
          fiyat = 0;
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          return true;
        },
    child: Scaffold(
      appBar: AppBar(
        title: const Text("Sepet"),
      ),
      body: BlocBuilder<SepetSayfaCubit,List<Sepet>>(
        builder:(context,sepetListesi){
          fiyat = 0;
          for(int i = 0; i<sepetListesi.length;i++){
            fiyat = fiyat + (int.parse(sepetListesi[i].yemek_fiyat)*int.parse(sepetListesi[i].yemek_siparis_adet));
            print(fiyat);
            text = "Toplam Fiyat : ${fiyat} ₺";
          }
          if(sepetListesi.isNotEmpty){
            return ListView.builder(
              itemCount: sepetListesi.length+1,
              itemBuilder: (context,indeks) {
                if(indeks !=sepetListesi.length){


                var sepet_yemek = sepetListesi[indeks];
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 150, height: 150,
                            child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepet_yemek.yemek_resim_adi}")),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sepet_yemek.yemek_adi, style: const TextStyle(fontSize: 25),),
                            const SizedBox(height: 50,),
                            Text("${sepet_yemek.yemek_fiyat} x ${sepet_yemek.yemek_siparis_adet} ₺", style: const TextStyle(fontSize: 20, color: Colors.blue),),
                            const SizedBox(height: 50,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("${sepet_yemek.yemek_siparis_adet} adet",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.blue),),
                                GestureDetector(onTap: () {
                                  print(
                                      "${sepet_yemek.yemek_adi} Add Tıklandı");
                                  //context.read<SepetSayfaCubit>().increase(sepet_yemek);
                                  context.read<SepetSayfaCubit>().guncelleme(sepet_yemek, "1");
                                  context.read<SepetSayfaCubit>().sepetiGetir();
                                }, child: Icon(Icons.add)),
                                GestureDetector(onTap: () {
                                  print("${sepet_yemek.yemek_adi} Remove Tıklandı");
                                  context.read<SepetSayfaCubit>().guncelleme(sepet_yemek, "-1");
                                  context.read<SepetSayfaCubit>().sepetiGetir();
                                }, child: Icon(Icons.remove)),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(onTap: () {
                          print("${sepet_yemek.yemek_adi} Delete Tıklandı");
                          context.read<SepetSayfaCubit>().sil(sepet_yemek.sepet_yemek_id);
                        }, child: Icon(Icons.delete)),
                      ],
                    ),
                  );
                }
                else{
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(text,style: const TextStyle(fontSize: 23,color: Colors.black87),),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }else{
            return const Center();
          }
        },
      ),
      ),
    );
  }
}
