import 'package:finance_tracker/providers/finance_provider.dart';
import 'package:finance_tracker/providers/finance_update_provider.dart';
import 'package:finance_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowFinanceUpdates extends StatelessWidget {
  final double targetAmount;
  final double currentSavings;
  final DateTime expectedDate;

  ShowFinanceUpdates({
    required this.targetAmount,
    required this.currentSavings,
    required this.expectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final financeUpdateProvider = Provider.of<FinanceUpdateProvider>(context);

    final financeProvider = Provider.of<FinanceProvider>(context);
    final selectedGoalIndex = financeProvider.getSelectedGoalIndex();

    FinanceValues selectedFinance =
        financeProvider.getFinanceDetails()[selectedGoalIndex];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Money Required:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\$${(selectedFinance.targetAmount - selectedFinance.currentAmount).toString()}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Monthly Saving Projection:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\$${financeUpdateProvider.calculateMonthlySavingProjection(selectedFinance.targetAmount, selectedFinance.currentAmount, selectedFinance.expectedDate).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
