import 'package:bitirme_projesi/ui/cubit/yemek_detay_cubit.dart';
import 'package:bitirme_projesi/ui/screen/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/data/entity/yemekler.dart';

class YemeklerDetay extends StatefulWidget {
  Yemekler yemek;

  YemeklerDetay({required this.yemek});

  @override
  State<YemeklerDetay> createState() => _YemeklerDetayState();
}

class _YemeklerDetayState extends State<YemeklerDetay> {
  var textFieldAdet = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFieldAdet.text="0";
  }
  Widget build(BuildContext context) {
    var sayfadakiYemek = widget.yemek;
    return Scaffold(
      appBar: AppBar(
        title: Text(sayfadakiYemek.yemek_adi),backgroundColor: Colors.red,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 120,height: 120,
                child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sayfadakiYemek.yemek_resim_adi}")
            ),
            Text("${sayfadakiYemek.yemek_fiyat} ₺",style: const TextStyle(fontSize: 28,color: Colors.blue),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(onTap: (){
                  //print("${sayfadakiYemek.yemek_adi} Add Tıklandı");
                  try{
                    int temp = int.parse(textFieldAdet.text);
                    temp = temp + 1;
                    textFieldAdet.text = temp.toString();
                  }
                  catch(e){
                    print("please type a numeric value");
                  }

                },child: Icon(Icons.add)),
                SizedBox(height: 50,width: 50,
                    child: TextField(controller: textFieldAdet,
                      ),
                ),

                GestureDetector(onTap: (){
                  //print("${sayfadakiYemek.yemek_adi} Remove Tıklandı");
                  try{
                    int temp = int.parse(textFieldAdet.text);
                    temp = temp - 1;
                    textFieldAdet.text = temp.toString();
                  }
                  catch(e){
                    print("please type a numeric value");
                  }
                },child: Icon(Icons.remove)),
              ],
            ),
            ElevatedButton(onPressed: (){
              if(isNumeric(textFieldAdet.text) && (int.parse(textFieldAdet.text))>0){
                context.read<YemekDetayCubit>().increase(sayfadakiYemek,textFieldAdet.text);
              }else{
                print("please type a numeric value");
              }
            }, child: const Text("Sepete Ekle")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa()))
              .then((value) { textFieldAdet.text="0"; });
        },
        child: const Icon(Icons.shopping_basket_outlined),
      ),
    );
  }
  bool isNumeric(String str) {
    try{
      var value = double.parse(str);
    } on FormatException {
      return false;
    } finally {
      return true;
    }
  }
}


