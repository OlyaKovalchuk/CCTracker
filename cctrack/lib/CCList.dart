import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/models.dart';

class CCList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList> {
  List<CCData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(Colors.grey, Colors.black, 0.8),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(" CC Tracker", style: TextStyle(color: Colors.amberAccent)),
        leading: Icon(
          Icons.widgets_rounded,
          color: Colors.amberAccent,
        ),
      ),
      body: Container(
          child: ListView(
        children: _buildList(),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC(),
      ),
    );
  }
  void initState(){
    _loadCC();
  }

  _loadCC() async {
    final response = await http.get('https://api.coinlore.net/api/tickers/?start=0&limit=30');
    if (response.statusCode == 200) {
      var responseData= json.decode(response.body);
      var allData = responseData['data'] as List<dynamic>;
      List<CCData> ccDataList = [];
      allData.forEach((val){
        var record = CCData(name: val['name'],
            symbol: val['symbol'], rank: val['rank'], price_usd: val['price_usd']);
        ccDataList.add(record);
      });
      setState(() {
        data = ccDataList;
      });
    }
  }


  List<Widget> _buildList() {
    return data
        .map((CCData f) => ListTile(
              title: Text(f.symbol, style: TextStyle(color: Colors.amberAccent),),
              subtitle: Text(f.name, style: TextStyle(color: Colors.grey)),
              leading: CircleAvatar( backgroundColor: Colors.black54,
                  child: Text(f.rank.toString(), style: TextStyle(color: Colors.amberAccent))),
              trailing: Text('\$${f.price_usd}', style: TextStyle(color: Colors.grey)),
            ))
        .toList();
  }
}
