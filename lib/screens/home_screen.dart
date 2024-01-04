import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:finance_tracker/providers/finance_provider.dart';
import 'package:finance_tracker/widgets/circular_chart_widget.dart';
import 'package:finance_tracker/widgets/contribution_history_widget.dart';
import 'package:finance_tracker/widgets/goal_details_widget.dart';

class FinanceValues {
  late String title;
  double currentAmount;
  double targetAmount;
  late String expectedDate;
  Color color;

  FinanceValues(
    this.title,
    this.currentAmount,
    this.targetAmount,
    this.expectedDate,
    this.color,
  );
}

class HomeScreen extends StatelessWidget {
  // Declare staticFinanceValues as a member variable
  final List<FinanceValues> staticFinanceValues = [
    FinanceValues('Dream Home', 3500000, 5200000, '2026-01-01', Colors.blue),
    FinanceValues('Dream Car', 4700000, 15000000, '2027-02-01', Colors.green),
    FinanceValues(
        'Invested Amount', 1300000, 2000000, '2029-03-01', Colors.red),
    FinanceValues('FD', 1250000, 1500000, '2025-03-01', Colors.yellow),
  ];

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    financeProvider.setFinanceValues(staticFinanceValues);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Finance Goals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (financeProvider.selectedGoal != null)
                SizedBox(
                  height: 400,
                  child: CircularChartWidget(
                    tooltipBehavior: TooltipBehavior(enable: true),
                  ),
                )
              else
                SizedBox(
                  height: 400,
                  child: CircularChartWidget(
                    tooltipBehavior: TooltipBehavior(enable: true),
                  ),
                ),
              const SizedBox(height: 20),
              GoalDetailsWidget(),
              const SizedBox(height: 20),
              ContributionHistoryWidget(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDataBottomSheet(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddDataBottomSheet(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController currentSavingsController = TextEditingController();
    TextEditingController targetAmountController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Add Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: currentSavingsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Current Savings'),
              ),
              TextField(
                controller: targetAmountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Target Amount'),
              ),
              Row(
                children: [
                  const Text('Select Date:'),
                  TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedDate) {
                        selectedDate = pickedDate;
                      }
                    },
                    child: Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      currentSavingsController.text.isNotEmpty &&
                      targetAmountController.text.isNotEmpty) {
                    FinanceValues newData = FinanceValues(
                      titleController.text,
                      double.parse(currentSavingsController.text),
                      double.parse(targetAmountController.text),
                      "${selectedDate.toLocal()}".split('')[0],
                      Colors.blue,
                    );

                    // Update the static list for demonstration
                    staticFinanceValues.add(newData);

                    // Update the dynamic list in the FinanceProvider
                    Provider.of<FinanceProvider>(context, listen: false)
                        .addFinanceValue(newData);

                    // Update contributionHistory
                    Provider.of<FinanceProvider>(context, listen: false)
                        .addContributionHistoryData(ContributionHistoryData(
                      date: "${selectedDate.toLocal()}".split('')[0],
                      amount: double.parse(currentSavingsController.text),
                    ));

                    // Update CircularChart
                    Provider.of<FinanceProvider>(context, listen: false)
                        .updateSelectedGoal(newData);

                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ContributionHistoryData {
  ContributionHistoryData({
    required this.date,
    required this.amount,
  });

  late String date;
  final double amount;
}

List<ContributionHistoryData> contributionHistory = [];
