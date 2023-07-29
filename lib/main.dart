import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_billmaker/pdf_design.dart';
import 'package:pdf_billmaker/splash_screen.dart';
import 'package:pdf_billmaker/tableData.dart';
import 'sale_page.dart';

void main() {
  runApp(const home());
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class bill extends StatefulWidget {
  bill({super.key});

  @override
  State<bill> createState() => _billState();
}

class _billState extends State<bill> {
  var pdf = pw.Document();
  var save;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => add_item_page(),
              ));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          title: const Text(
            'Invoice Generator',
            style: TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 25),
          ),
          centerTitle: true),
      body: invoice.isNotEmpty
          ? ListView.builder(
              itemCount: invoice.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  title: Text(
                    "Customer Name\n${invoice[index].customerName}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  trailing: SizedBox(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pdf_design(),
                                      settings:
                                          RouteSettings(arguments: index)));
                            },
                            child: const Icon(
                              Icons.picture_as_pdf_rounded,
                              color: Colors.purple,
                            )),
                        InkWell(
                            onTap: () {
                              invoice.removeAt(index);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.delete_rounded,
                              color: Colors.redAccent.withOpacity(0.8),
                            )),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/folder.png",
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    "No Invoice Found...",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                        letterSpacing: 2),
                  ),
                ],
              ),
            ),
    );
  }
}
