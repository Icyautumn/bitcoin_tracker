import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map<String, String> coinValues = {};
  String bitcoinValue = '1';
  bool isWaiting = false;

  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  void getData(String selected_Currency) async {
    isWaiting = true;
    try {
      var Data = await CoinData().getBTCData(selected_Currency);

      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        coinValues = Data;

      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            getData(selectedCurrency);
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> scrollitems = [];
    for (String currency in currenciesList) {
      scrollitems.add(Text(currency));
    }

    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
        },
        children: scrollitems);
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData('USD');
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          cryptoCard(
            value:  coinValues['BTC']??"",
            selectedCurrency: selectedCurrency,
            cryptoCurrency: 'BTC',
          ),
          cryptoCard(
            value: coinValues['ETH']??"",
            selectedCurrency: selectedCurrency,
            cryptoCurrency: 'BTC',
          ),
          cryptoCard(
            value: coinValues['LTC']??"",
            selectedCurrency: selectedCurrency,
            cryptoCurrency: 'LTC',
          ),

          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: Text(
          //         '1 ${cryptoList[1]} = $EtherValueInUSD $selectedCurrency',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: Text(
          //         '1 ${cryptoList[2]} = $LTCValueInUSD $selectedCurrency',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),


          Container(
              height: 150.0,
              alignment: Alignment(0.0, -1.0),
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isAndroid ? androidDropdown() : iOSPicker()),
        ],
      ),
    );
  }
}

class cryptoCard extends StatelessWidget {

  const cryptoCard({
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ${cryptoCurrency} = $value $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );

  }
}

