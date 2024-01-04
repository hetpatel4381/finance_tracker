import 'package:finance_tracker/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContributionHistoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contribution History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: financeProvider.contributionHistory.length,
            itemBuilder: (context, index) {
              final contribution = financeProvider.contributionHistory[index];
              return ListTile(
                title: Text(
                  'Date: ${contribution.date.toString()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                subtitle: Text(
                  'Amount: \$${contribution.amount.toString()}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
