import 'package:finance_tracker/providers/finance_provider.dart';
import 'package:finance_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class CircularChartWidget extends StatelessWidget {
  const CircularChartWidget({
    Key? key,
    required this.tooltipBehavior,
  }) : super(key: key);

  final TooltipBehavior tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    // Use selectedGoal if available, otherwise use the first element
    FinanceValues selectedGoal =
        financeProvider.selectedGoal ?? financeProvider.financeValues.first;

    return SfCircularChart(
      title: const ChartTitle(
        text: 'Goals',
        textStyle: TextStyle(
          color: Colors.blue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      legend: const Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        RadialBarSeries<FinanceValues, String>(
          dataSource: [selectedGoal], // Show only the selected goal
          cornerStyle: CornerStyle.bothCurve,
          maximumValue: 100,
          gap: '2%',
          xValueMapper: (FinanceValues data, _) =>
              '${data.title}\n${data.targetAmount.toString()}',
          yValueMapper: (FinanceValues data, _) =>
              (data.currentAmount / data.targetAmount) * 100,
          pointColorMapper: (FinanceValues data, _) => data.color,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
            textStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
