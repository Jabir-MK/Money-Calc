// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:money_calc/data/expense_data.dart';
import 'package:money_calc/models/expense_item.dart';
import 'package:money_calc/view/home/widget/expense_summary.dart';
import 'package:money_calc/view/home/widget/expense_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // text controllers
  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController expenseAmountcontroller = TextEditingController();
  // add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: expenseNameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Expense Title',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: expenseAmountcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Expense Amount',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: save,
            child: Text('Save', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: cancel,
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  // save
  void save() {
    // Expense item
    if (expenseAmountcontroller.text.isEmpty ||
        expenseNameController.text.isEmpty) {
      return;
    } else {
      ExpenseItem expenseItem = ExpenseItem(
        name: expenseNameController.text,
        amount: expenseAmountcontroller.text,
        dateTime: DateTime.now(),
      );
      // Adding new expense item
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(expenseItem);
    }

    Navigator.of(context).pop();
    clearControllers();
  }

  void delete(ExpenseItem expenseItem) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expenseItem);
  }

  void cancel() {
    Navigator.of(context).pop();
    clearControllers();
  }

  // clear value of controllers after use
  void clearControllers() {
    expenseAmountcontroller.clear();
    expenseNameController.clear();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            // Weekly summary graph
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),
            const SizedBox(height: 20),
            // Expense list
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenses().length,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  child: ExpenseTile(
                    name: value.getAllExpenses()[index].name,
                    amount: value.getAllExpenses()[index].amount,
                    dateTime: value.getAllExpenses()[index].dateTime,
                    onDeletetap: (p0) => delete(value.getAllExpenses()[index]),
                  ),
                );
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: Icon(Icons.add_rounded, size: 45),
        ),
      ),
    );
  }
}
