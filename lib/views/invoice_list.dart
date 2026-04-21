// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:invoice_app/controller/invoice_controller.dart';

// class InvoiceList extends StatelessWidget {
//   InvoiceList({Key? key}) : super(key: key);

//   final InvoiceController controller = Get.find<InvoiceController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Invoices"),
//         centerTitle: true,
//       ),
//       body: Obx(() {
//         // agar empty hai
//         if (controller.invoices.isEmpty) {
//           return const Center(
//             child: Text(
//               "No Invoices Found",
//               style: TextStyle(fontSize: 16),
//             ),
//           );
//         }

//         // list show
//         return ListView.builder(
//           itemCount: controller.invoices.length,
//           itemBuilder: (context, index) {
//             var data = controller.invoices[index];

//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: ListTile(
//                 contentPadding: const EdgeInsets.all(12),

//                 // Client Name
//                 title: Text(
//                   data['client'],
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),

//                 // Details
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 5),
//                     Text("Invoice No: ${data['no']}"),
//                     Text("Total: ₹ ${data['total'].toStringAsFixed(2)}"),
//                   ],
//                 ),

//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

////     //// ////// ////////    /////
///
///
///
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/controller/invoice_controller.dart';
import '../services/pdf_service.dart';
import 'invoice_detail.dart';

class InvoiceList extends StatelessWidget {
  InvoiceList({super.key});

  final InvoiceController controller = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Invoices"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        if (controller.invoices.isEmpty) {
          return const Center(
            child: Text("No Invoices Found"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.invoices.length,
          itemBuilder: (context, index) {
            var data = controller.invoices[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => InvoiceDetail(data: data));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔥 Top Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data['client'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "₹ ${data['total']}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 8),

                    // 🔹 Invoice No
                    Text(
                      "Invoice No: ${data['no']}",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 5),

                    // 🔹 GST (optional)
                    if (data.containsKey('gst'))
                      Text(
                        "GST: ₹ ${data['gst']}",
                        style: const TextStyle(color: Colors.grey),
                      ),

                    const SizedBox(height: 10),
                    const Divider(),

                    // 🔥 Bottom Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "View Details",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.picture_as_pdf,
                              color: Colors.red),
                          onPressed: () {
                            generatePdf(data);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
