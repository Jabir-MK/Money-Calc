import 'package:flutter/material.dart';
import 'package:money_calc/data/db_functions.dart';
import 'package:money_calc/datetime/datetime_helper.dart';
import 'package:money_calc/models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // List of all expenses
  List<ExpenseItem> overAllExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenses() {
    return overAllExpenseList;
  }

  final db = DataBaseOps();

  // Prepare data to display
  void prepareData() {
    if (db.getData().isNotEmpty) {
      overAllExpenseList = db.getData();
    }
  }

  // add expense
  void addNewExpense(ExpenseItem newExpense) {
    overAllExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overAllExpenseList);
  }

  //  delete expense
  void deleteExpense(ExpenseItem expenseItem) {
    overAllExpenseList.remove(expenseItem);
    notifyListeners();
    db.saveData(overAllExpenseList);
  }

  //  get weekday from datetime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get date for start of week (sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get today's date
    DateTime today = DateTime.now();
    // go backwards from today to find sunday
    for (var i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  // convertion of overall expense of daily summary
  Map<String, double> calculateDailyExpense() {
    Map<String, double> dailyExpense = {};
    for (var expense in overAllExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);
      if (dailyExpense.containsKey(date)) {
        double currentAmount = dailyExpense[date]!;
        currentAmount += amount;
        dailyExpense[date] = currentAmount;
      } else {
        dailyExpense.addAll({date: amount});
      }
    }
    return dailyExpense;
  }
}
