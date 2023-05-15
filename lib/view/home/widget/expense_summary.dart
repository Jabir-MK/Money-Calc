import 'package:flutter/material.dart';
import 'package:money_calc/data/expense_data.dart';
import 'package:money_calc/datetime/datetime_helper.dart';
import 'package:money_calc/view/home/bar_graph/bar_graph.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  final DateTime startOfWeek;

  double calculateMax(
    ExpenseData value,
    String sun,
    String mon,
    String tue,
    String wed,
    String thu,
    String fri,
    String sat,
  ) {
    double? max = 100;
    List<double> values = [
      value.calculateDailyExpense()[sun] ?? 0,
      value.calculateDailyExpense()[mon] ?? 0,
      value.calculateDailyExpense()[tue] ?? 0,
      value.calculateDailyExpense()[wed] ?? 0,
      value.calculateDailyExpense()[thu] ?? 0,
      value.calculateDailyExpense()[fri] ?? 0,
      value.calculateDailyExpense()[sat] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpenseData value,
    String sun,
    String mon,
    String tue,
    String wed,
    String thu,
    String fri,
    String sat,
  ) {
    List<double> values = [
      value.calculateDailyExpense()[sun] ?? 0,
      value.calculateDailyExpense()[mon] ?? 0,
      value.calculateDailyExpense()[tue] ?? 0,
      value.calculateDailyExpense()[wed] ?? 0,
      value.calculateDailyExpense()[thu] ?? 0,
      value.calculateDailyExpense()[fri] ?? 0,
      value.calculateDailyExpense()[sat] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    // get date for each day of week
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          // Total amount of the week
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const Text(
                  'Total Amount (Week) :  ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ' \u{20B9} ${calculateWeekTotal(
                    value,
                    sunday,
                    monday,
                    tuesday,
                    wednesday,
                    thursday,
                    friday,
                    saturday,
                  )}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            child: BarGraph(
              maxY: calculateMax(
                value,
                sunday,
                monday,
                tuesday,
                wednesday,
                thursday,
                friday,
                saturday,
              ),
              sunAmount: value.calculateDailyExpense()[sunday] ?? 0,
              monAmount: value.calculateDailyExpense()[monday] ?? 0,
              tueAmount: value.calculateDailyExpense()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpense()[wednesday] ?? 0,
              thuAmount: value.calculateDailyExpense()[thursday] ?? 0,
              friAmount: value.calculateDailyExpense()[friday] ?? 0,
              satAmount: value.calculateDailyExpense()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
