// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/client_controller.dart';
// import '../controller/invoice_controller.dart';

// import '../services/pdf_service.dart';

// class CreateInvoice extends StatefulWidget {
//   const CreateInvoice({super.key});

//   @override
//   State<CreateInvoice> createState() => _CreateInvoiceState();
// }

// class _CreateInvoiceState extends State<CreateInvoice> {
//   final invoiceCtrl = Get.find<InvoiceController>();
//   final clientCtrl = Get.find<ClientController>();

//   String? selectedClient;
//   List items = [];

//   void addItem() {
//     setState(() {
//       items.add({"name": "", "price": 0.0, "qty": 1});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Create Invoice")),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             DropdownButton<String>(
//               hint: const Text("Select Client"),
//               value: selectedClient,
//               items: clientCtrl.clients
//                   .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                   .toList(),
//               onChanged: (val) => setState(() => selectedClient = val),
//             ),
//             ElevatedButton(onPressed: addItem, child: const Text("Add Item")),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (_, i) {
//                   return ListTile(
//                     title: TextField(
//                       onChanged: (v) => items[i]['name'] = v,
//                       decoration: const InputDecoration(hintText: "Item"),
//                     ),
//                     subtitle: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             keyboardType: TextInputType.number,
//                             onChanged: (v) =>
//                                 items[i]['price'] = double.parse(v),
//                             decoration:
//                                 const InputDecoration(hintText: "Price"),
//                           ),
//                         ),
//                         Expanded(
//                           child: TextField(
//                             keyboardType: TextInputType.number,
//                             onChanged: (v) => items[i]['qty'] = int.parse(v),
//                             decoration: const InputDecoration(hintText: "Qty"),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (selectedClient == null) {
//                   Get.snackbar("Error", "Please select a client");
//                   return;
//                 }

//                 if (items.isEmpty) {
//                   Get.snackbar("Error", "Add at least one item");
//                   return;
//                 }

//                 invoiceCtrl.addInvoice(selectedClient!, items);

//                 var last = invoiceCtrl.invoices.last;
//                 generatePdf(last);

//                 Get.back();
//               },
//               child: const Text("Save & PDF"),
//             )

//             // ElevatedButton(
//             //   onPressed: () {
//             //     invoiceCtrl.addInvoice(selectedClient!, items);
//             //     var last = invoiceCtrl.invoices.last;
//             //     generatePdf(last);
//             //     Get.back();
//             //   },
//             //   child: const Text("Save & PDF"),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/controller/client_controller.dart';
import 'package:invoice_app/controller/invoice_controller.dart';

import '../services/pdf_service.dart';

class CreateInvoice extends StatefulWidget {
  const CreateInvoice({super.key});

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {
  final invoiceCtrl = Get.find<InvoiceController>();
  final clientCtrl = Get.find<ClientController>();

  String? selectedClient;
  List items = [];

  void addItem() {
    setState(() {
      items.add({"name": "", "price": 0.0, "qty": 1});
    });
  }

  double getTotal() {
    double total = 0;
    for (var i in items) {
      total += (i['price'] ?? 0) * (i['qty'] ?? 0);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Create Invoice"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🔥 Client Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Select Client"),
                  value: selectedClient,
                  isExpanded: true,
                  items: clientCtrl.clients
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedClient = val;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🔥 Add Item Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: addItem,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  "Add Item",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 Item List
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          decoration:
                              const InputDecoration(labelText: "Item Name"),
                          onChanged: (v) => items[i]['name'] = v,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(labelText: "Price"),
                                onChanged: (v) =>
                                    items[i]['price'] = double.tryParse(v) ?? 0,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(labelText: "Qty"),
                                onChanged: (v) =>
                                    items[i]['qty'] = int.tryParse(v) ?? 1,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔥 Total Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Subtotal: ₹ ${getTotal().toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "GST (18%): ₹ ${(getTotal() * 0.18).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Divider(),
                  Text(
                    "Total: ₹ ${(getTotal() * 1.18).toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedClient == null) {
                    Get.snackbar("Error", "Select client");
                    return;
                  }
                  if (items.isEmpty) {
                    Get.snackbar("Error", "Add items");
                    return;
                  }

                  invoiceCtrl.addInvoice(selectedClient!, items);

                  var last = invoiceCtrl.invoices.last;
                  generatePdf(last);

                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.all(14),
                ),
                child: const Text(
                  "Generate Invoice",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
