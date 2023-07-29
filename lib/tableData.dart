class model {
  String? customerName;
  String? total;
  List? itemData;
  String? phoneNumber;
  dynamic billDate;

  model(
      {this.customerName,
      this.total,
      this.itemData,
      this.phoneNumber,
      required this.billDate});
}

List<model> invoice = [];
