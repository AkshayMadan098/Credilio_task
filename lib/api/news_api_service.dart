import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService{
  String apiKey="45a656d53bcb4a57b0803a0977561ce5";
  List? articlesList;

  Future<List?> getNewsData() async {
    String url = "https://newsapi.org/v2/everything?q=tesla&from=2024-10-18&sortBy=publishedAt&apiKey=$apiKey";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      articlesList = jsonDecode(response.body)["articles"];
      print("Fetched articles: $articlesList");
      return articlesList;
    } else {
      print("No response from API");
      return null;
    }
  }
}