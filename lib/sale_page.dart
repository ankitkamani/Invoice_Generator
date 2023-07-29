import 'package:flutter/material.dart';
import 'package:pdf_billmaker/addItem.dart';
import 'package:pdf_billmaker/tableData.dart';
import 'package:intl/intl.dart';

class add_item_page extends StatefulWidget {
  const add_item_page({super.key});

  @override
  State<add_item_page> createState() => _add_item_pageState();
}


class _add_item_pageState extends State<add_item_page> {
  var Formkey = GlobalKey<FormState>();
  var customerController = TextEditingController();
  var phoneNoController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    num totle() {
      num totlle = 0;
      for (var i = 0; i <= tempData.length - 1; i++) {
        totlle += tempData[i][1] * tempData[i][2];
      }
      return totlle;
    }
    int len = invoice.length + 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale'),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black12,
        child: Column(children: [
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Invoice No."),
                    )),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Date"),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("$len"),
                    )),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000));

                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              print(selectedDate);
                              selectedDate = picked;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Text(DateFormat.yMMMMd().format(selectedDate)),
                            const Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            // height: 400,
            width: double.infinity,
            color: Colors.white,
            child: Column(children: [
              Form(
                key: Formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Customer name is Required";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          controller: customerController,
                          decoration: const InputDecoration(
                              hintText: "e.g. ankit kamani",
                              labelText: "Customer*",
                              border: OutlineInputBorder())),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone Number is Required";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: phoneNoController,
                          decoration: const InputDecoration(
                              hintText: "e.g. 000-0000-000",
                              labelText: "Phone Number*",
                              border: OutlineInputBorder())),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async{
                   await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => addItem(),
                        ));
                   setState(() {});
                  },
                  child: Text("Add Items")),
              SizedBox(
                height: 20,
              )
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(children: [
                Container(
                  color: Colors.greenAccent.shade200,
                  height: 30,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    "Final Items",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      tempData.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: tempData.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text("${tempData[index][0]}"),
                                    subtitle: Text(
                                        "Quantity : ${tempData[index][1]} \nPrize : ${tempData[index][2]}"),
                                    trailing: Text(
                                        "Total : ${tempData[index][1] * tempData[index][2]}"),
                                  );
                                },
                              ),
                            )
                          : const Expanded(
                              child: Center(
                                  child: Text(
                                "Not Final Items Found...",
                                style: TextStyle(fontSize: 18),
                              )),
                            ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Total : ${totle()}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              if (Formkey.currentState!.validate()&& tempData.isNotEmpty) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirm"),
                      content: Text.rich(TextSpan(
                          text: "Sure You Went To Save & Generate Bill...?\n\n",
                          children: [
                            TextSpan(
                                text: "Note :",
                                style: TextStyle(
                                    color: Colors.red.shade800,
                                    fontWeight: FontWeight.bold)),
                            const TextSpan(
                                text:
                                " Once Save & Generate Bill After Not Change The Bill.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic))
                          ])),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                invoice.add(model(
                                  billDate: DateFormat.yMMMMd().format(selectedDate),
                                    total: totle().toString(),
                                    customerName:
                                    customerController.text.toString(),
                                    itemData: tempData,
                                    phoneNumber: phoneNoController.text
                                        .toString()));
                                customerController.text='';
                                phoneNoController.text='';
                                Navigator.pop(context);
                                Navigator.pop(context);
                                tempData=[];
                              });
                            },
                            child: const Text("Save"))
                      ],
                    );
                  },
                );
              }else{
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Required Items"),
                      content: const Text("Bill Item is Required..."),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const addItem(),));
                            },
                            child: const Text("Add Now"))
                      ],
                    );
                  },
                );
              }
            },
            color: Colors.redAccent.shade700,
            child: const Text(
              "Save & Generate Bill",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}
