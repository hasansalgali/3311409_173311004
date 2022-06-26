import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cepfinans/bilgilendirme.dart';
import 'package:cepfinans/iletisim.dart';
import 'democard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'cevirici.dart';
import 'portfoy.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'themechanger.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  var usdFiyat = '00.00';
  var eurFiyat = '00.00';
  var jpyFiyat = '00.00';
  var gbpFiyat = '00.00';
  var cnyFiyat = '00.00';
  var rubFiyat = '00.00';
  Map<String, String> userHeader = {"X-Requested-With": "XMLHttpRequest"};

  dynamic fetchCoin() async {
    final response = await http.get(
        Uri.parse('https://www.haremaltin.com/ajax/all_prices'),
        headers: userHeader);
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      print(values['data']['USDTRY']['alis']);
      setState(() {
        usdFiyat = values['data']['USDTRY']['alis'].toString();
        eurFiyat = values['data']['EURTRY']['alis'].toString();
        gbpFiyat = values['data']['GBPTRY']['alis'].toString();
        cnyFiyat = values['data']['CNYTRY']['alis'].toString();
        rubFiyat = values['data']['RUBTRY']['alis'].toString();
      });
      return values;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    DovizSayfasi(),
    AltinSayfasi(),
    CeviriciSayfasi(),
    PortfoySayfasi(),
    GrafikSayfasi(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(Duration(seconds: 2), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();
    final theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 130,
        backgroundColor: Colors.black,
        title: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onDoubleTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Colors.black
                                : Color(0xFF737373),
                          ),
                          child: Container(
                            // color: Colors.black,
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.home,
                                  title: 'Ana Sayfa',
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.info,
                                  title: 'Bilgilendirme',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BilgilendirmeSayfasi()));
                                  },
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onDoubleTapCancel: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Colors.black
                                : Color(0xFF737373),
                          ),
                          child: Container(
                            // color: Colors.black,
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.home,
                                  title: 'Ana Sayfa',
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.info,
                                  title: 'Bilgilendirme',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BilgilendirmeSayfasi()));
                                  },
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Colors.black
                                : Color(0xFF737373),
                          ),
                          child: Container(
                            // color: Colors.black,
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.home,
                                  title: 'Ana Sayfa',
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.info,
                                  title: 'Bilgilendirme',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BilgilendirmeSayfasi()));
                                  },
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onSecondaryTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Colors.black
                                : Color(0xFF737373),
                          ),
                          child: Container(
                            // color: Colors.black,
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.home,
                                  title: 'Ana Sayfa',
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.info,
                                  title: 'Bilgilendirme',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BilgilendirmeSayfasi()));
                                  },
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onLongPressUp: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Colors.black
                                : Color(0xFF737373),
                          ),
                          child: Container(
                            // color: Colors.black,
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.home,
                                  title: 'Ana Sayfa',
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.info,
                                  title: 'Bilgilendirme',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BilgilendirmeSayfasi()));
                                  },
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? Colors.black
                                : Color(0xFF737373),
                          ),
                          child: Container(
                            // color: Colors.black,
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.home,
                                  title: 'Ana Sayfa',
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ModalMenuButton(
                                  icon: FontAwesomeIcons.info,
                                  title: 'Bilgilendirme',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BilgilendirmeSayfasi()));
                                  },
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: FaIcon(FontAwesomeIcons.bars),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 45,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Container(
              height: 80,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 80.0,
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'USD',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          usdFiyat.toString().substring(0, 5),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    thickness: 0.5,
                    endIndent: 20,
                    indent: 20,
                    width: 20,
                  ),
                  Container(
                    width: 80.0,
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'EUR',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          eurFiyat.toString().substring(0, 5),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    thickness: 0.5,
                    endIndent: 20,
                    indent: 20,
                    width: 20,
                  ),
                  Container(
                    width: 80.0,
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'GBP',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          gbpFiyat.toString().substring(0, 5),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  DikeyCizgi(),
                  Container(
                    width: 80.0,
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CNY',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          cnyFiyat.toString().substring(0, 5),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  DikeyCizgi(),
                  Container(
                    width: 80.0,
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'RUB',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          rubFiyat.toString().substring(0, 5),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.black
                : Colors.white,
        iconSize: 20,
        showUnselectedLabels: true,
        selectedItemColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.white
                : Colors.black,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.dollarSign),
            label: 'Döviz',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.coins),
            label: 'Altın',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.exchangeAlt),
            label: 'Çevirici',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.wallet),
            label: 'Portföy',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartLine),
            label: 'Grafik',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Container(
        child: _widgetOptions.elementAt(
          _selectedIndex,
        ),
        color: Colors.white,
      ),
    );
  }
}

class DikeyCizgi extends StatelessWidget {
  const DikeyCizgi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Colors.grey.shade400,
      thickness: 0.5,
      endIndent: 20,
      indent: 20,
      width: 20,
    );
  }
}

class ModalMenuButton extends StatelessWidget {
  const ModalMenuButton(
      {required this.icon,
      required this.title,
      required this.onPressed,
      required this.color});
  final IconData icon;
  final String title;
  final onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.all(0),
      child: ListTile(
        leading: Icon(
          this.icon,
          color: this.color,
        ),
        title: Text(
          this.title,
          style: TextStyle(
            color: this.color,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class DovizSayfasi extends StatefulWidget {
  const DovizSayfasi({Key? key}) : super(key: key);

  @override
  _DovizSayfasiState createState() => _DovizSayfasiState();
}

class _DovizSayfasiState extends State<DovizSayfasi> {
  bool isWaiting = true;
  var generalData;
  Map<String, String> userHeader = {"X-Requested-With": "XMLHttpRequest"};

  dynamic fetchCoin() async {
    final response = await http.get(
        Uri.parse('https://www.haremaltin.com/ajax/all_prices'),
        headers: userHeader);
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      print(values);
      setState(() {
        isWaiting = false;
        generalData = values;
      });
      _write(generalData.toString());
      return values;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  List<String> currenciesList = [
    'USDTRY',
    'EURTRY',
    'GBPTRY',
    'CHFTRY',
    'CADTRY',
    'RUBTRY',
    'AEDTRY',
    'AUDTRY',
    'DKKTRY',
    'SEKTRY',
    'NOKTRY',
    'JPYTRY',
    'CNYTRY',
    'KWDTRY',
    'JODTRY',
    'SARTRY',
    'BGNTRY',
    'QARTRY',
    'ILSTRY',
    'MADTRY',
  ];
  List<String> cL2 = [
    'USD',
    'EUR',
    'GBP',
    'CHF',
    'CAD',
    'RUB',
    'AED',
    'AUD',
    'DKK',
    'SEK',
    'NOK',
    'JPY',
    'CNY',
    'KWD',
    'JOD',
    'SAR',
    'BGN',
    'QAR',
    'ILS',
    'MAD',
  ];
  List<String> currenciesNames = [
    'Amerikan Doları',
    'Euro',
    'İngiliz Sterlini',
    'İsviçre Frangı',
    'Kanada Doları',
    'Rus Rublesi',
    'BAE Dirhemi',
    'Avustralya Doları',
    'Danimarka Kronu',
    'İsveç Kronu',
    'Norveç Kronu ',
    'Japon Yeni',
    'Çin Yuanı',
    'Kuveyt Dinarı',
    'Ürdün Dinarı',
    'Suudi Riyali',
    'Bulgar Levası',
    'Katar Riyali',
    'Yeni İsrail Şekeli',
    'Fas Dirhemi',
  ];

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(Duration(seconds: 2), (timer) => fetchCoin());
    super.initState();
  }
  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/dovizdata.txt');
    await file.writeAsString(text);
  }

  Future<String> _read() async {
    String text = '';
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/dovizdata.txt');
      text = await file.readAsString();
    } catch (e) {
      print("Okunamadi");
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    var _controller = ScrollController();
    ScrollPhysics _physics = ClampingScrollPhysics();
    final theme = Provider.of<ThemeChanger>(context);
    if (isWaiting == true) {
      return Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Expanded(
                      child:
                          Text('Birim', style: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 115,
                    ),
                    Expanded(
                      child: Text('Alış', style: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 90,
                    ),
                    Expanded(
                      child:
                          Text('Satış', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: currenciesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DemoCard(
                        type: 'doviz',
                        name: cL2[index],
                        fullName: currenciesNames[index],
                        alis: double.parse(generalData['data']
                                    [currenciesList[index]]['alis']
                                .toString())
                            .toStringAsFixed(2),
                        satis: double.parse(generalData['data']
                                    [currenciesList[index]]['satis']
                                .toString())
                            .toStringAsFixed(2),
                        deger: generalData['data'][currenciesList[index]]['dir']
                                ['satis_dir']
                            .toString(),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class GrafikSayfasi extends StatefulWidget {
  const GrafikSayfasi({Key? key}) : super(key: key);

  @override
  _GrafikSayfasiState createState() => _GrafikSayfasiState();
}

class _GrafikSayfasiState extends State<GrafikSayfasi> {
  bool isWaiting = true;
  var generalData;
  Map<String, String> userHeader = {"X-Requested-With": "XMLHttpRequest"};

  dynamic fetchCoin() async {
    final response = await http.get(
        Uri.parse('https://www.haremaltin.com/ajax/all_prices'),
        headers: userHeader);
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      print(values);
      setState(() {
        isWaiting = false;
        generalData = values;
      });
      List<DovizVeri> gecici = [];
      gecici.add(DovizVeri("USD",
          double.parse(generalData['data']["USDTRY"]["satis"].toString())));
      gecici.add(DovizVeri("EUR",
          double.parse(generalData['data']["EURTRY"]["satis"].toString())));
      gecici.add(DovizVeri("GBP",
          double.parse(generalData['data']["GBPTRY"]["satis"].toString())));
      gecici.add(DovizVeri("CNY",
          double.parse(generalData['data']["CNYTRY"]["satis"].toString())));

      setState(() {
        dovizGrafik = gecici;
      });

      return values;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  List<DovizVeri> dovizGrafik = [];

  List<String> currenciesList = [
    'USDTRY',
    'EURTRY',
    'GBPTRY',
    'CHFTRY',
    'CADTRY',
    'RUBTRY',
    'AEDTRY',
    'AUDTRY',
    'DKKTRY',
    'SEKTRY',
    'NOKTRY',
    'JPYTRY',
    'CNYTRY',
    'KWDTRY',
    'JODTRY',
    'SARTRY',
    'BGNTRY',
    'QARTRY',
    'ILSTRY',
    'MADTRY',
  ];
  List<String> cL2 = [
    'USD',
    'EUR',
    'GBP',
    'CHF',
    'CAD',
    'RUB',
    'AED',
    'AUD',
    'DKK',
    'SEK',
    'NOK',
    'JPY',
    'CNY',
    'KWD',
    'JOD',
    'SAR',
    'BGN',
    'QAR',
    'ILS',
    'MAD',
  ];
  List<String> currenciesNames = [
    'Amerikan Doları',
    'Euro',
    'İngiliz Sterlini',
    'İsviçre Frangı',
    'Kanada Doları',
    'Rus Rublesi',
    'BAE Dirhemi',
    'Avustralya Doları',
    'Danimarka Kronu',
    'İsveç Kronu',
    'Norveç Kronu ',
    'Japon Yeni',
    'Çin Yuanı',
    'Kuveyt Dinarı',
    'Ürdün Dinarı',
    'Suudi Riyali',
    'Bulgar Levası',
    'Katar Riyali',
    'Yeni İsrail Şekeli',
    'Fas Dirhemi',
  ];

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(Duration(seconds: 2), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _controller = ScrollController();
    ScrollPhysics _physics = ClampingScrollPhysics();
    final theme = Provider.of<ThemeChanger>(context);
    if (isWaiting == true) {
      return Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return PlayAnimation<Color?>(

          tween: ColorTween(begin: Colors.red, end: Colors.green),
          curve: Curves.easeInOut, // specify curve
          duration: const Duration(seconds: 5),
          delay: const Duration(seconds: 0), // add delay
          builder: (context, child, value) {
            return Container(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(text: 'Döviz Grafiği',textStyle: TextStyle(color: value, fontSize: 20)),
                        // Enable legend
                        borderWidth: 2,
                        plotAreaBorderWidth: 2,
                        series: <LineSeries>[
                          LineSeries<DovizVeri, String>(
                              dataSource: dovizGrafik,
                              xValueMapper: (DovizVeri sales, _) => sales.ad,
                              yValueMapper: (DovizVeri sales, _) => sales.satis,
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true))
                        ]),
                  ],
                ),
              ),
            );
          });
    }
  }
}

class DovizVeri {
  DovizVeri(
    this.ad,
    this.satis,
  );
  final String ad;
  final double satis;
}

class AltinSayfasi extends StatefulWidget {
  const AltinSayfasi({Key? key}) : super(key: key);

  @override
  _AltinSayfasiState createState() => _AltinSayfasiState();
}

class _AltinSayfasiState extends State<AltinSayfasi> {
  bool isWaiting = true;
  var generalData;
  Map<String, String> userHeader = {"X-Requested-With": "XMLHttpRequest"};

  dynamic fetchCoin() async {
    final response = await http.get(
        Uri.parse('https://www.haremaltin.com/ajax/all_prices'),
        headers: userHeader);
    if (response.statusCode == 200) {
      var values = json.decode(response.body);
      print(values);
      setState(() {
        generalData = values;
      });
      setState(() {
        isWaiting = false;
      });
      return values;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  List<String> currenciesList = [
    'ALTIN',
    'ONS',
    'AYAR14',
    'AYAR22',
    'KULCEALTIN',
    'CEYREK_YENI',
    'CEYREK_ESKI',
    'YARIM_YENI',
    'YARIM_ESKI',
    'TEK_YENI',
    'TEK_ESKI',
    'ATA_YENI',
    'ATA_ESKI',
    'ATA5_YENI',
    'ATA5_ESKI',
    'GREMESE_YENI',
    'GREMESE_ESKI',
    'GUMUSTRY',
    'PLATIN',
    'PALADYUM',
  ];
  List<String> currenciesNames = [
    'Altın',
    'Ons',
    '14 Ayar',
    '22 Ayar',
    'Külçe Altın',
    'Çeyrek Altın Yeni',
    'Çeyrek Altın Eski',
    'Yarım Altın Yeni',
    'Yarım Altın Eski',
    'Tek Altın Yeni',
    'Tek Altın Eski',
    'Ata Yeni',
    'Ata Eski',
    'Ata 5 Yeni',
    'Ata 5 Eski',
    'Gremese Yeni',
    'Gremese Eski',
    'Gümüş',
    'Platin',
    'Paladyum',
  ];

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(Duration(seconds: 2), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    var _controller = ScrollController();
    ScrollPhysics _physics = ClampingScrollPhysics();
    if (isWaiting == true) {
      return Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            child: ListView.builder(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: currenciesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return DemoCard(
                    type: 'altin',
                    name: currenciesNames[index],
                    fullName: currenciesNames[index],
                    alis: double.parse(generalData['data']
                                [currenciesList[index]]['alis']
                            .toString())
                        .toStringAsFixed(2),
                    satis: double.parse(generalData['data']
                                [currenciesList[index]]['satis']
                            .toString())
                        .toStringAsFixed(2),
                    deger: generalData['data'][currenciesList[index]]['dir']
                            ['satis_dir']
                        .toString(),
                  );
                }),
          ),
        ),
      );
    }
  }
}
