import 'package:hive/hive.dart';
import 'package:money_calc/models/expense_item.dart';

class DataBaseOps {
  // reference box
  final myBox = Hive.box('ExpenseDB');
  // add data

  void saveData(List<ExpenseItem> allExpense) {
    // Not the Way I do (mitchkoko version hive db)

    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    myBox.put('ALL_EXPENSES', allExpensesFormatted);
  }
  // read data

  List<ExpenseItem> getData() {
    List savedExpenses = myBox.get('ALL_EXPENSES') ?? [];
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expenseItem = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );
      allExpenses.add(expenseItem);
    }
    return allExpenses;
  }
}
