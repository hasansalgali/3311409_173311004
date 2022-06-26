// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'themechanger.dart';
import 'package:provider/provider.dart';

class DemoCard extends StatefulWidget {
  final String type;
  final String name;
  final String fullName;
  final String alis;
  final String satis;
  final String deger;

  DemoCard({
    required this.type,
    required this.name,
    required this.fullName,
    required this.alis,
    required this.satis,
    required this.deger,
  });
  @override
  _DemoCardState createState() => _DemoCardState();
}

class _DemoCardState extends State<DemoCard> {
  parser(String str) {
    var dbl = double.parse(str.replaceAll(',', ''));
    return dbl;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return Column(
      children: [
        Card(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          elevation: 0,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.type == 'altin' ? widget.name : widget.name,
                      style: TextStyle(
                          fontSize: widget.type == 'altin' ? 15 : 16,
                          color: Colors.grey),
                    ),
                    Text(
                      widget.type == 'altin' ? '' : widget.fullName,
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
              ),
              Expanded(
                child: Text(
                  widget.alis,
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.satis,
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    widget.deger == 'down'
                        ? Icon(
                            FontAwesomeIcons.arrowDown,
                            color: Colors.red,
                          )
                        : widget.deger == 'up'
                            ? Icon(
                                FontAwesomeIcons.arrowUp,
                                color: Colors.green,
                              )
                            : Icon(
                                FontAwesomeIcons.arrowsAltH,
                                color: Colors.grey,
                              ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          indent: 8,
          endIndent: 8,
          thickness: 0.9,
          height: 4,
        ),
      ],
    );
  }
}
