// ignore_for_file: prefer_const_constructors
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'themechanger.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'dart:async';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CeviriciSayfasi extends StatefulWidget {
  const CeviriciSayfasi({Key? key}) : super(key: key);

  @override
  _CeviriciSayfasiState createState() => _CeviriciSayfasiState();
}

class _CeviriciSayfasiState extends State<CeviriciSayfasi> {
  List<String> currenciesList = [
    'USDTRY',
    'EURTRY',
    'TRYTRY'
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
    'TRY',
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

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  String? area1;
  String? area2;
  String dropdownValue = 'USD';
  String dropdownValue2 = 'EUR';
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
      return Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Birim Çevirici',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(color: Colors.grey),
                            controller: controller1,
                            onChanged: (value) {
                              setState(
                                () {
                                  if (dropdownValue == 'TRY' ||
                                      dropdownValue2 == 'TRY') {
                                    if (dropdownValue == 'TRY' &&
                                        dropdownValue2 != 'TRY') {
                                      double x = double.parse(
                                              controller1.text) /
                                          double.parse(generalData['data']
                                                      [dropdownValue2 + 'TRY']
                                                  ['alis']
                                              .toString()
                                              .replaceAll(',', '.'));
                                      controller2.text = x.toStringAsFixed(2);
                                    } else if (dropdownValue2 == 'TRY' &&
                                        dropdownValue != 'TRY') {
                                      double y = double.parse(generalData[
                                                          'data']
                                                      [dropdownValue + 'TRY']
                                                  ['alis']
                                              .toString()
                                              .replaceAll(',', '.')) *
                                          double.parse(controller1.text);
                                      controller2.text = y.toStringAsFixed(2);
                                    } else if (dropdownValue == 'TRY' &&
                                        dropdownValue2 == 'TRY') {
                                      controller2.text = controller1.text;
                                    }
                                  } else {
                                    double a;

                                    a = double.parse(controller1.text) *
                                        double.parse(generalData['data']
                                                [dropdownValue + 'TRY']['alis']
                                            .toString()
                                            .replaceAll(',', '.'));

                                    double b;

                                    b = a /
                                        double.parse(generalData['data']
                                                [dropdownValue2 + 'TRY']['alis']
                                            .toString()
                                            .replaceAll(',', '.'));
                                    controller2.text = b.toStringAsFixed(0);
                                  }
                                },
                              );
                            },
                            cursorColor: Colors.grey,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Miktarı Girin',
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
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.grey),
                            readOnly: true,
                            controller: controller2,
                            onChanged: (value) {
                              setState(() {});
                            },
                            cursorColor: Colors.grey,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Sonuç',
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
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: DropdownButton<String>(
                                menuMaxHeight: 500,
                                value: dropdownValue,
                                icon: const Icon(FontAwesomeIcons.ellipsisH),
                                iconSize: 24,
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
                                items: cL2.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Center(child: Text(value)),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Center(
                              child: DropdownButton<String>(
                                menuMaxHeight: 500,
                                value: dropdownValue2,
                                icon: const Icon(FontAwesomeIcons.ellipsisH),
                                iconSize: 24,
                                elevation: 1,
                                borderRadius: BorderRadius.circular(8),
                                style: const TextStyle(color: Colors.grey),
                                underline: Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue2 = newValue!;
                                  });
                                },
                                items: cL2.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Center(child: Text(value)),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
