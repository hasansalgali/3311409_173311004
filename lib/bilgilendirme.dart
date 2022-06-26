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
                    'Burada yer alan haberler, döviz kurları ve altın fiyatları bilgi amaçlıdır. Yayınlanan bilgiler yatırım danışmanlığı kapsamında değildir. Sadece burada yer alan bilgilere dayanarak yatırım kararları verilmesi beklentilerinize uygun sonuçlar doğurmayabilir. Uygulama üzerinde kullanılan verilerin kaynaklarındaki hata ve eksikliklerden dolay uygulama üzerindeki veriler zaman zaman hatalı olabilir. Bu nedenle buradaki verilere dayanarak yatırımcilarin uğrayabileceği doğrudan ve/veya dolaylı zararlardan ya da kar yoksunluğundan ve manevi zararlardan dolayı uygulama sahibi hiçbir şekilde sorumlu tutulamaz.',
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
