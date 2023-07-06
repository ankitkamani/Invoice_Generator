import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_billmaker/main.dart';
import 'package:pdf_billmaker/tableData.dart';

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: align,
      ),
    );

Future<Uint8List> design(String title) async {
  final pdf = Document();
  String name = "Ankit Kamani";
  String phone_number = "9913955095";
  String invoice_number = "1";


  pdf.addPage(
    Page(
      build: (Context context) => Column(children: [
        SizedBox(
          height: 50,
        ),
        Center(child: Text("Cash / Credit Bill")),
        Table(border: TableBorder.all(color: PdfColors.black), children: [
          TableRow(children: [
            Expanded(flex:3,child: PaddedText("Name: ${name.toUpperCase()}")),
            Expanded(flex:1,child: PaddedText("Invoice No. : $invoice_number"))
          ]),
          TableRow(children: [
            PaddedText("Ph. No.: $phone_number"),
          ]),
        ]),
        Table(
          border: TableBorder.all(color: PdfColors.black),
          children: [
            TableRow(
              children: [
                Padding(
                  child: Text(
                    'Sr no.',
                    style: Theme.of(context).header4,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20),
                ),
                Padding(
                  child: Text(
                    'Products',
                    style: Theme.of(context).header4,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20),
                ),
                Padding(
                  child: Text(
                    'Qty.',
                    style: Theme.of(context).header4,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20),
                ),
                Padding(
                  child: Text(
                    'Rate',
                    style: Theme.of(context).header4,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20),
                ),
                Padding(
                  child: Text(
                    'Amount',
                    style: Theme.of(context).header5,
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(20),
                ),
              ],
            ),

            ...invoice.map(
              (e) => TableRow(
                children: [
                  Expanded(
                    child: PaddedText("${e["Sr no"]}", align: TextAlign.center),
                    flex: 2,
                  ),
                  Expanded(
                    child: PaddedText(e["product_name"]),
                    flex: 3,
                  ),
                  Expanded(
                    child: PaddedText("${e["quantity"]}"),
                    flex: 2,
                  ),
                  Expanded(
                    child: PaddedText("\$${e["rate"]}"),
                    flex: 2,
                  ),
                  Expanded(
                    child: PaddedText("\$${e["rate"] * e["quantity"]}"),
                    flex: 2,
                  ),
                ],
              ),
            ),
            TableRow(
              children: [
                PaddedText(""),
                PaddedText(""),
                PaddedText(""),
                PaddedText('TAX', align: TextAlign.right),
                PaddedText('\$${(invoice[0]["quantity"])}'),
              ],
            ),
            // Show the total
            TableRow(
              children: [
                PaddedText(""),
                PaddedText(""),
                PaddedText(""),
                PaddedText('TOTAL', align: TextAlign.right),
                PaddedText("\$${total()}"),
              ],
            )
          ],
        ),
        Padding(
          child: Text(
            "THANK YOU FOR YOUR BUSINESS!",
            style: Theme.of(context).header2,
          ),
          padding: EdgeInsets.all(20),
        ),
      ]),
    ),
  );

  // final file = File('example.pdf');
  // await file.writeAsBytes(await pdf.save());
  return await pdf.save();
}
