import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/screen/yemek_detay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/anasayfa_cubit.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnasayfaCubit>().yemekleriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yemekler"),
      ),
      body: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
        builder:(context,yemeklerListesi){
          if(yemeklerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: yemeklerListesi.length,
                itemBuilder: (context,indeks) {
                  var yemek = yemeklerListesi[indeks];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => YemeklerDetay(yemek: yemek)))
                          .then((value) { context.read<AnasayfaCubit>().yemekleriGetir(); });
                    },
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(width: 150, height: 150,
                              child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(yemek.yemek_adi, style: const TextStyle(fontSize: 25),),
                              const SizedBox(height: 50,),
                              Text("${yemek.yemek_fiyat} ₺", style: const TextStyle(fontSize: 20, color: Colors.blue),),

                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
                },
            );
          }else{
            return const Center();
            }
        },
      ),
    );
  }
}
