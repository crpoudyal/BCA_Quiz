import 'dart:developer';

import 'package:bca_quiz/utils/colors.dart';
import 'package:bca_quiz/widgets/sem_container.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> titles = [];
  List<String> dates = [];
  List<String> dlinks = [];

  @override
  void initState() {
    super.initState();
    getDataFromWeb();
  }

  Future getDataFromWeb() async {
    final url = Uri.parse('https://www.tufohss.edu.np/index.php/notices/');
    final response = await http.get(url);
    final body = response.body;
    final html = parse(body);
    final titles = html
        .querySelectorAll(' tbody > tr:not(:first-child) > td:first-child')
        .map((element) => element.innerHtml.trim())
        .toList();
    log(titles.toString());
    final dates = html
        .querySelectorAll('tbody>tr:not(:first-child)>td:nth-child(1)')
        .map((e) => e.innerHtml.trim())
        .toList();
    final dlinks = html
        .querySelectorAll('tbody>tr:not(:first-child)>td:nth-child(2)>a')
        .map((e) => e.innerHtml.trim())
        .toList();
    log(dlinks.toString());
    setState(() {
      this.titles = titles;
      this.dates = dates;
      this.dlinks = dlinks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/BCAquiz.png',
              height: 64,
            ),
            const SizedBox(
              width: 92,
            ),
            const Text("BCA Quiz"),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 140,
            color: mobileBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Prepare For Your Exam',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check_box,
                        size: 12,
                        color: Color(0xFF50DDF6),
                      ),
                      Text(
                        " Quizes at any time anywhere",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check_box,
                        size: 12,
                        color: Color(0xFF50DDF6),
                      ),
                      Text(
                        " MCQ for all semester",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                      child: Text(
                        'Play Now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Semester",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              children: [
                semContainer("First", Colors.blueAccent, Icons.code),
                semContainer("Second", Colors.redAccent, Icons.code),
                semContainer("Third", Colors.greenAccent, Icons.code),
                semContainer("Fourth", Colors.blueGrey, Icons.code),
                semContainer("Fifth", Colors.purpleAccent, Icons.code),
                semContainer("Sixth", Colors.cyan, Icons.code),
                semContainer("Seventh", Colors.deepOrangeAccent, Icons.code),
                semContainer("Eighth", Colors.brown, Icons.code),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Notices",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  final title = titles[index];
                  final date = dates[index];
                  final dlink = dlinks[index];
                  return ListTile(
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
                    trailing: IconButton(
                      icon: const Icon(Icons.download),
                      color: mobileBackgroundColor,
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
