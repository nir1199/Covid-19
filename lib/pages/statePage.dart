import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatePage extends StatefulWidget {
  StatePage({Key key}) : super(key: key);

  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  List stateData;
  Map data;
  fetchstateData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    setState(() {
      data = json.decode(response.body);
      stateData = data["statewise"];
    });
  }

  @override
  void initState() {
    fetchstateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STATE Stats"),
      ),
      body: stateData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 140,
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 10,
                        offset: Offset(0, 10)),
                  ]),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              stateData[index + 1]['state'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Card(
                                      color: Colors.red[100],
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            '+' +
                                                stateData[index + 1]
                                                    ['deltaconfirmed'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 13.0),
                                          ),
                                          Text(stateData[index + 1]
                                              ['confirmed']),
                                          Text(
                                            'CONFIRMED',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 13.0),
                                          ),
                                        ],
                                      )),
                                  Card(
                                      color: Colors.green[100],
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            '+' +
                                                stateData[index + 1]
                                                    ['deltarecovered'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                                fontSize: 13.0),
                                          ),
                                          Text(stateData[index + 1]
                                              ['recovered']),
                                          Text(
                                            'RECOVERED',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                                fontSize: 13.0),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Card(
                                      color: Colors.blue[100],
                                      child: Column(
                                        children: <Widget>[
                                          Text(""),
                                          Text(
                                            stateData[index + 1]['active'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                fontSize: 13.0),
                                          ),
                                          Text(
                                            '    ACTIVE    ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                fontSize: 13.0),
                                          ),
                                        ],
                                      )),
                                  Card(
                                      color: Colors.grey[100],
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            '+' +
                                                stateData[index + 1]
                                                    ['deltadeaths'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 13.0),
                                          ),
                                          Text(stateData[index + 1]['deaths']),
                                          Text(
                                            '   DEATHS   ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 13.0),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: stateData == null ? 0 : stateData.length - 1,
            ),
    );
  }
}
