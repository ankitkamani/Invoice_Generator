import 'package:flutter/material.dart';

class addItem extends StatefulWidget {
  const addItem({super.key});

  @override
  State<addItem> createState() => _addItemState();
}

List tempData = [];

class _addItemState extends State<addItem> {
  var controlleritemname = TextEditingController();
  var controllerprize = TextEditingController();
  var controllerqt = TextEditingController();
  var keyform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: keyform,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Item Name",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      TextFormField(
                        validator: (value) {
                          if(value?.isEmpty??false){
                            return "Item Name is Required";
                          }
                          return null;
                        },
                          keyboardType: TextInputType.name,
                          controller: controlleritemname,
                          decoration: const InputDecoration(
                            hintText: "Eg. Apple",
                            border: OutlineInputBorder(),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Item Quantity",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      TextFormField(
                          validator: (value) {
                            if(value?.isEmpty??false){
                              return "Quantity is Required";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: controllerqt,
                          decoration: const InputDecoration(
                              hintText: "eg.1", border: OutlineInputBorder())),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Item Prize",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      TextFormField(
                          validator: (value) {
                            if(value?.isEmpty??false){
                              return "Prize is Required";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: controllerprize,
                          decoration: const InputDecoration(
                              hintText: "Rs.100", border: OutlineInputBorder())),
                    ]),
              ),
            ),
          ),
          Container(
            color: Colors.grey,
            height: 30,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Already Add Items",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child:tempData.isNotEmpty ? ListView.builder(
              itemCount: tempData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${tempData[index][0]}"),
                  subtitle: Text("Quantity : ${tempData[index][1]} \nPrize : ${tempData[index][2]}"),
                  trailing: InkWell(onTap: () {
                    setState(() {
                      tempData.removeAt(index);
                    });
                  },child: const Icon(Icons.delete)),
                );
              },
            ):const Center(child: Text("Not Item Found...")),
          ),
          Container(
            height: 60,
            color: Colors.blue.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: () {
                      setState(() {
                        tempData;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Save")),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.grey),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: () {
                      setState(() {
                        if(keyform.currentState!.validate()){
                          tempData.add([
                            controlleritemname.text.toString(),
                            int.parse(controllerqt.text),
                        int.parse(controllerprize.text)
                          ]);
                          controlleritemname.text = '';
                          controllerqt.text = '';
                          controllerprize.text = '';
                        }
                      });
                    },
                    child: const Text("Add To List",)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
