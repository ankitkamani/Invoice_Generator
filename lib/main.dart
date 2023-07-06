import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_billmaker/pdf_design.dart';
import 'package:printing/printing.dart';

List<Map> invoice = [
  {"Sr no":1,"product_name": "silver", "rate": 70000, "quantity": 5},
  {"Sr no":2,"product_name": "gold", "rate": 60000, "quantity": 2},
  {"Sr no":3,"product_name": "silver", "rate": 30000, "quantity": 20}
];

num total(){
  num totalamount=0;
  for(int i=0;i<invoice.length;i++){
   totalamount += (invoice[i]["rate"])*(invoice[i]["quantity"]);
  }
  return totalamount;
}

void main() {
  runApp(billl());
}

class billl extends StatelessWidget {
  const billl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: bill(),
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
          setState(() {
            save = design("Pdf demo");
          });
          // save = await pdf.save();
        },
      ),
      body: save != null
          ? PdfPreview(
              build: (format) async => await save,
            )
          : Container(),
    );
  }
}
