import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_tracker/providers/finance_provider.dart';

class GoalDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: financeProvider.getFinanceDetails().length,
          itemBuilder: (context, index) {
            final finance = financeProvider.getFinanceDetails()[index];
            return GestureDetector(
              onTap: () {
                financeProvider.updateSelectedGoal(finance);
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        finance.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Amount Saved: \$${finance.currentAmount.toString()}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Target Amount: \$${finance.targetAmount.toString()}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Expected Date: ${finance.expectedDate}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
