import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/yemek_detay_cubit.dart';
import 'package:bitirme_projesi/ui/screen/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}
var bgcolor = const Color(0xFFE32636);
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AnasayfaCubit()),
      BlocProvider(create: (context) => YemekDetayCubit()),
      BlocProvider(create: (context) => SepetSayfaCubit()),
    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}