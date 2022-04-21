import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinapi = 'https://rest.coinapi.io/v1/exchangerate/';
const apikey = '7FE64C40-E8AD-4CA7-8094-8693685962A3';

class CoinData {
  String btc = 'BTC';
  String eth = 'ETH';
  String ltc = 'LTC';
  Future getBTCData(String Selected_Currency) async {
    String requestURL_BTC = '$coinapi$btc/$Selected_Currency?apikey=$apikey';

    http.Response response_BTC = await http.get(Uri.parse(requestURL_BTC));

    if (response_BTC.statusCode == 200) {
      var decodeData = jsonDecode(response_BTC.body);

      var last_price = decodeData['rate'];

      return last_price;
    } else {
      print(response_BTC.statusCode);
      throw 'Problem with the get request';
    }
  }
  Future getETHData(String Selected_Currency) async {
    String requestURL_ETH = '$coinapi$eth/$Selected_Currency?apikey=$apikey';

    http.Response response_ETH = await http.get(Uri.parse(requestURL_ETH));

    if (response_ETH.statusCode == 200) {
      var decodeData = jsonDecode(response_ETH.body);

      var last_price = decodeData['rate'];

      return last_price;
    } else {
      print(response_ETH.statusCode);
      throw 'Problem with the get request';
    }
  }
  Future getLTCData(String Selected_Currency) async {
    String requestURL_LTC = '$coinapi$ltc/$Selected_Currency?apikey=$apikey';

    http.Response response_LTC = await http.get(Uri.parse(requestURL_LTC));

    if (response_LTC.statusCode == 200) {
      var decodeData = jsonDecode(response_LTC.body);

      var last_price = decodeData['rate'];

      return last_price;
    } else {
      print(response_LTC.statusCode);
      throw 'Problem with the get request';
    }
  }
}
