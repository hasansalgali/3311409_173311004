import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'themechanger.dart';

class BilgilendirmeSayfasi extends StatefulWidget {
  const BilgilendirmeSayfasi({Key? key}) : super(key: key);

  @override
  State<BilgilendirmeSayfasi> createState() => _BilgilendirmeSayfasiState();
}

class _BilgilendirmeSayfasiState extends State<BilgilendirmeSayfasi> {
  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();
    final theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        title: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 45,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.vertical,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bilgilendirme',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Burada yer alan haberler, d??viz kurlar?? ve alt??n fiyatlar?? bilgi ama??l??d??r. Yay??nlanan bilgiler yat??r??m dan????manl?????? kapsam??nda de??ildir. Sadece burada yer alan bilgilere dayanarak yat??r??m kararlar?? verilmesi beklentilerinize uygun sonu??lar do??urmayabilir. Uygulama ??zerinde kullan??lan verilerin kaynaklar??ndaki hata ve eksikliklerden dolay uygulama ??zerindeki veriler zaman zaman hatal?? olabilir. Bu nedenle buradaki verilere dayanarak yat??r??mcilarin u??rayabilece??i do??rudan ve/veya dolayl?? zararlardan ya da kar yoksunlu??undan ve manevi zararlardan dolay?? uygulama sahibi hi??bir ??ekilde sorumlu tutulamaz.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
