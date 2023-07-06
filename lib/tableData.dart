import 'package:flutter/material.dart';

class tableData extends StatefulWidget {
  const tableData({super.key});

  @override
  State<tableData> createState() => _tableDataState();
}

class _tableDataState extends State<tableData> {
  @override
  Widget build(BuildContext context) {
    return DataTable(columns: const [
      DataColumn(label: Text("Sr no.")),
      DataColumn(label: Text("Products")),
      DataColumn(label: Text("Rate")),
      DataColumn(label: Text("Quantity")),
      DataColumn(label: Text("Amount")),
    ], rows: [
      ...List.generate(
        5,
        (index) => DataRow(cells: [
          DataCell(Text("$index")),
          DataCell(Text("abc$index")),
          const DataCell(Text("100")),
          DataCell(Text("$index")),
          DataCell(Text("${index*100}")),
        ]),
      )
    ]);
  }
}
