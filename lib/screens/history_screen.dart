import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DUMMY DATA: Replace with a list of historical disposal records
    final List<Map<String, String>> disposalHistory = [
      {'date': 'Sep 09, 2025', 'type': 'Organic', 'quantity': '2.1 kg', 'points': '+10'},
      {'date': 'Sep 08, 2025', 'type': 'Recyclable', 'quantity': '3.5 kg', 'points': '+15'},
      {'date': 'Sep 07, 2025', 'type': 'Organic', 'quantity': '1.8 kg', 'points': '+8'},
      {'date': 'Sep 06, 2025', 'type': 'Hazardous', 'quantity': '0.5 kg', 'points': '+5'},
      {'date': 'Sep 05, 2025', 'type': 'Recyclable', 'quantity': '2.0 kg', 'points': '+12'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Disposal History'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: disposalHistory.length,
        itemBuilder: (context, index) {
          final item = disposalHistory[index];
          final color = item['type'] == 'Organic'
              ? Colors.green
              : item['type'] == 'Recyclable'
              ? Colors.blue
              : Colors.orange;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(
                  item['type'] == 'Organic'
                      ? Icons.eco
                      : item['type'] == 'Recyclable'
                      ? Icons.recycling
                      : Icons.warning,
                  color: color,
                ),
              ),
              title: Text(item['type']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${item['date']} - ${item['quantity']}'),
              trailing: Text(
                '${item['points']} pts',
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
