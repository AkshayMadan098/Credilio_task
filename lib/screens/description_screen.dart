import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionScreen extends StatelessWidget {
  final String? title;
  final String? description;
  final String? url;
  final String? image;
  const DescriptionScreen({super.key,this.url,this.title,this.description,this.image});

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url!))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen2"),
      ),
      body: Column(
        children: [
          Image.network(image!),
          const SizedBox(height:10,),
          Text(title!,style: const TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height:10,),
          GestureDetector(
              onTap: _launchUrl,
              child: Text("Url: $url",style: const TextStyle(color: Colors.blue),)
          ),
          const SizedBox(height:10,),
          description==null?const SizedBox():Text(description!)
        ],
      ),
    );
  }
}
