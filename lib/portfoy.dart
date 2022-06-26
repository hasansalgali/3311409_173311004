// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'dart:async';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'personmodel.dart';
import 'dbfunctions.dart';
import 'package:provider/provider.dart';
import 'themechanger.dart';

class PortfoySayfasi extends StatefulWidget {
  const PortfoySayfasi({Key? key}) : super(key: key);

  @override
  _PortfoySayfasiState createState() => _PortfoySayfasiState();
}

class _PortfoySayfasiState extends State<PortfoySayfasi> {
  @override
  String? name;
  String? amount = '0';
  String? buyPrice = '0';
  String? area1;
  String? dropdownValue = 'USDTRY';
  String? sumAll = '0';
  final _auth = FirebaseAuth.instance;

  User? loggedInUser;
  Future<List<Person>> readSql() async {
    var dbUtil = DBUtil();
    Future<List<Person>> data = dbUtil.readAll();
    return data;
  }

  readData() {
    var dbUtil = DBUtil();
    Future<Person> data = dbUtil.read(name!);
    data.then((value) {
      print(value.name);
    });
  }

  createData() {
    var dbUtil = DBUtil();
    if (dropdownValue == 'TRY') {
      if (amount == null) {
        amount = '0';
      }
      buyPrice = '1';
    }
    var person = Person(1, dropdownValue, amount == null ? '0' : amount,
        buyPrice == null ? '0' : buyPrice);
    dbUtil.create(person);
    createFireDocument();
  }

  createFireDocument() {
    var person = Person(1, dropdownValue, amount == null ? '0' : amount,
        buyPrice == null ? '0' : buyPrice);

    Map<String, dynamic> portfoyitem = {
      "item": dropdownValue,
      "miktar": amount == null ? '0' : amount,
      'alis': buyPrice == null ? '0' : buyPrice,
    };

    FirebaseFirestore.instance
        .collection(_auth.currentUser!.uid)
        .add(portfoyitem)
        .then((docRef) {});
  }

  deleteData(int id) {
    var dbUtil = DBUtil();
    dbUtil.delete2(id);
  }

  var generalData;
  Map<String, String> userHeader = {"X-Requested-With": "XMLHttpRequest"};

  dynamic fetchCoin() async {
    final response = await http.get(
        Uri.parse('https://www.haremaltin.com/ajax/all_prices'),
        headers: userHeader);
    if (response.statusCode == 200) {
      var values = json.decode(response.body);

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
    'USDTRY',
    'EURTRY',
    'GBPTRY',
    'TRY',
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
  List<String> currenciesNames = [];
  bool isWaiting = true;
  @override
  void initState() {
    fetchCoin();
    Timer.periodic(Duration(seconds: 1), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String calc(String data1, String data2) {
      double a = double.parse(data1.replaceAll(',', '.')) *
          double.parse(data2.replaceAll(',', '.'));
      return a.toStringAsFixed(0);
    }

    String calc2(String data1, String data2, String data3, String data4) {
      double a = double.parse(data1.replaceAll(',', '.')) *
              double.parse(data2.replaceAll(',', '.')) -
          double.parse(data3.replaceAll(',', '.')) *
              double.parse(data4.replaceAll(',', '.'));
      return a.toStringAsFixed(0);
    }

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
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Portföyüm',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 140,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Miktar',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (value) {
                              amount = value;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 140,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Alış Fiyatı',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (value) {
                              buyPrice = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton<String>(
                          menuMaxHeight: 500,
                          value: dropdownValue,
                          icon: const Icon(FontAwesomeIcons.ellipsisH),
                          iconSize: 23,
                          elevation: 1,
                          alignment: AlignmentDirectional.centerStart,
                          borderRadius: BorderRadius.circular(8),
                          style: const TextStyle(color: Colors.grey),
                          underline: Container(
                            height: 2,
                            width: 10,
                            color: Colors.grey,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: currenciesList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(child: Text(value)),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                createData();
                              });
                            },
                            child: Text(
                              'Ekle',
                              style: TextStyle(color: Colors.grey),
                            )),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: Text(
                          'Varlık',
                          style: TextStyle(color: Colors.grey),
                        )),
                        Expanded(
                            child: Text(
                          'Miktar',
                          style: TextStyle(color: Colors.grey),
                        )),
                        Expanded(
                            child: Text(
                          'Alış F.',
                          style: TextStyle(color: Colors.grey),
                        )),
                        Expanded(
                            child: Text(
                          'Tutar',
                          style: TextStyle(color: Colors.grey),
                        )),
                        Expanded(
                            child: Text(
                          'K/Z',
                          style: TextStyle(color: Colors.grey),
                        )),
                        Expanded(
                            child: Text(
                          'Eylem',
                          style: TextStyle(color: Colors.grey),
                        )),
                      ],
                    ),
                    FutureBuilder<List<Person>>(
                        future: readSql(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.length > 0) {
                            return SizedBox(
                              height: 400,
                              child: ListView.builder(
                                  shrinkWrap: false,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    String? subTotal = '0';
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++) {
                                      subTotal = (snapshot.data![index].name ==
                                              'TRY'
                                          ? (int.parse(subTotal!) +
                                                  int.parse(snapshot
                                                      .data![index].amount!))
                                              .toString()
                                          : ((int.parse(subTotal!) +
                                                  int.parse(calc(
                                                      generalData['data'][snapshot
                                                              .data![index]
                                                              .name!]['alis']
                                                          .toString(),
                                                      snapshot.data![index]
                                                          .amount!)))
                                              .toString()));
                                    }

                                    sumAll = subTotal;

                                    print(subTotal! + '!!!!!!!!!!!!!!!!!');
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot.data![index].name!,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data![index].amount
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data![index].buyPrice
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data![index].name == 'TRY'
                                                ? snapshot.data![index].amount!
                                                : calc(
                                                    generalData['data'][snapshot
                                                            .data![index]
                                                            .name!]['alis']
                                                        .toString(),
                                                    snapshot
                                                        .data![index].amount!),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data![index].name == 'TRY'
                                                ? calc2(
                                                        '1',
                                                        snapshot.data![index]
                                                            .amount!
                                                            .toString(),
                                                        snapshot.data![index]
                                                            .amount!
                                                            .toString(),
                                                        snapshot.data![index].buyPrice!
                                                            .toString())
                                                    .toString()
                                                : calc2(
                                                        generalData['data'][snapshot
                                                                .data![index]
                                                                .name!]['alis']
                                                            .toString(),
                                                        snapshot.data![index]
                                                            .amount!
                                                            .toString(),
                                                        snapshot.data![index]
                                                            .amount!
                                                            .toString(),
                                                        snapshot.data![index]
                                                            .buyPrice!
                                                            .toString())
                                                    .toString(),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                onPressed: () {
                                                  setState(() {
                                                    deleteData(snapshot
                                                        .data![index].id!);
                                                  });
                                                },
                                                icon: FaIcon(
                                                  FontAwesomeIcons.trash,
                                                  color: Colors.grey,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    );
                                  }),
                            );
                          } else {
                            return Center(child: SizedBox());
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
