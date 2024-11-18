import 'package:flutter/material.dart';
import 'package:news_app/api/news_api_service.dart';
import 'package:news_app/screens/description_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NewsApiService newsApiService= NewsApiService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen1"),
      ),
      body: FutureBuilder(
        future: newsApiService.getNewsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: newsApiService.articlesList!.length,
              itemBuilder: (context, index) {
                final article = newsApiService.articlesList![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescriptionScreen(
                          title: article['title'] ?? '',
                          url: article['url'] ?? '',
                          description: article['description'] ?? '',
                          image: article['urlToImage'] ?? '',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        article['urlToImage'] == null
                            ? const SizedBox()
                            : Image.network(article['urlToImage']),
                        const SizedBox(height: 10),
                        Text(
                          article['title'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        article['publishedAt'] == null
                            ? const SizedBox()
                            : Text(article['publishedAt']),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
