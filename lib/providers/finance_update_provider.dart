import 'package:flutter/foundation.dart';

class FinanceUpdateProvider with ChangeNotifier {
  double calculateMonthlySavingProjection(
    double targetAmount,
    double currentSavings,
    DateTime expectedDate,
  ) {
    DateTime currentDate = DateTime.now();
    int monthsDifference = calculateMonthsDifference(currentDate, expectedDate);
    double monthlySavingProjection =
        (targetAmount - currentSavings) / monthsDifference;

    return monthlySavingProjection;
  }

  int calculateMonthsDifference(DateTime currentDate, DateTime expectedDate) {
    return (expectedDate.year - currentDate.year) * 12 +
        expectedDate.month -
        currentDate.month;
  }
}
