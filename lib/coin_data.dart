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
  Map<String, String> exchange_Rates = {};
  List<String> Crypto_Curriencies = ['BTC', 'ETH', 'LTC'];
  Future getBTCData(String Selected_Currency) async {
    for (String crypto in Crypto_Curriencies) {
      String requestURL = '$coinapi$crypto/$Selected_Currency?apikey=$apikey';
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);

        double last_Price = decodeData['rate'];
        exchange_Rates[crypto] = last_Price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return exchange_Rates;
  }
}
