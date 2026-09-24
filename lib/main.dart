import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/DetaySayfa.dart';

import 'Kelimeler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Anasayfa(title: 'Flutter Demo Home Page'),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key, required this.title});



  final String title;

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<Kelimeler>> tumKelimelerGoster() async {
    var kelimelerListesi = <Kelimeler>[];
    var k1 = Kelimeler(1, "Dog", "Köpek");
    var k2 = Kelimeler(2, "Fish", "Balık");
    var k3 = Kelimeler(3, "Table", "Masa");

    kelimelerListesi.add(k1);
    kelimelerListesi.add(k2);
    kelimelerListesi.add(k3);

    return kelimelerListesi;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: aramaYapiliyorMu ?
            TextField(
              decoration: InputDecoration(hintText: "Arama için bir şey yazın"),
              onChanged: (aramaSonucu){
                print("Arama Sonucu: $aramaSonucu");
                setState(() {
                  aramaKelimesi = aramaSonucu;
                });
              },
            )
            : Text("Sözlük Uygulaması"),
        actions: [
          aramaYapiliyorMu ? IconButton(
      icon: Icon(Icons.cancel),
      onPressed: (){
        setState(() {
          aramaYapiliyorMu = false;
          aramaKelimesi = "";
        });
      },
    )
          : IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future: tumKelimelerGoster(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kelimelerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kelimelerListesi!.length,
              itemBuilder: (context,indeks){
                var kelime = kelimelerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kelime: kelime,)));
                  },
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(kelime.turkce),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return Center();
          }
        },
      ),
    );
  }
}
