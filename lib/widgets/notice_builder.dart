import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NoticesBuilder extends StatelessWidget {
  const NoticesBuilder({
    Key? key,
    required this.titles,
    required this.dates,
    required this.dlinks,
  }) : super(key: key);

  final List<String> titles;
  final List<String> dates;
  final List<String> dlinks;

  @override
  Widget build(BuildContext context) {
    return
      titles.isEmpty?const Center(child: CircularProgressIndicator(),): ListView.builder(
        physics:
        const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final title = titles[index];

          final date = dates[index];
          final dlink = dlinks[index];
          return GestureDetector(
            onTap: () async {
              if (await canLaunchUrlString(dlink)) {
                await launchUrlString(dlink);
              }
            },
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.numbers),
              ),
              title: Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                date,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      );
  }
}
