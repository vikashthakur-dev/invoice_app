import 'package:flutter/material.dart';

class InvoiceDetail extends StatelessWidget {
  final Map data;

  const InvoiceDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Invoice Details"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Header Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Client: ${data['client']}",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text("Invoice No: ${data['no']}",
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text("Items",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            // 🔥 Items List
            Expanded(
              child: ListView.builder(
                itemCount: data['items'].length,
                itemBuilder: (_, i) {
                  var item = data['items'][i];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['name']),
                        Text("x${item['qty']}"),
                        Text("₹ ${item['price']}"),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 Total Section
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal"),
                      Text("₹ ${data['subtotal'] ?? data['total']}"),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("GST (18%)"),
                      Text("₹ ${data['gst'] ?? 0}"),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("₹ ${data['total']}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
