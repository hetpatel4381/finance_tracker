import 'package:flutter/material.dart';
import 'package:finance_tracker/screens/home_screen.dart';

class FinanceProvider extends ChangeNotifier {
  late List<FinanceValues> _financeValues = [];
  FinanceValues? _selectedGoal;
  List<ContributionHistoryData> _contributionHistory = [];

  List<FinanceValues> get financeValues => _financeValues;
  FinanceValues? get selectedGoal => _selectedGoal;
  List<ContributionHistoryData> get contributionHistory => _contributionHistory;

  void setFinanceValues(List<FinanceValues> financeValues) {
    _financeValues = financeValues;
    Future.microtask(() {
      notifyListeners();
    });
  }


  void updateSelectedGoal(FinanceValues selectedGoal) {
    _selectedGoal = selectedGoal;
    if (!_financeValues.contains(selectedGoal)) {
      _financeValues.add(selectedGoal);
    }

    notifyListeners();
  }

  void addFinanceValue(FinanceValues finance) {
    _financeValues.add(finance);
    notifyListeners();
  }

  void addContributionHistoryData(ContributionHistoryData contributionData) {
    _contributionHistory.add(contributionData);
    notifyListeners();
  }

  List<FinanceValues> getFinanceDetails() {
    return _financeValues;
  }

  int getSelectedGoalIndex() {
    if (_selectedGoal != null) {
      return _financeValues.indexOf(_selectedGoal!);
    }
    return 0;
  }
}
