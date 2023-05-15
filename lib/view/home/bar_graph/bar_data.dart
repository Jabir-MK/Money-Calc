import 'package:money_calc/view/home/bar_graph/individual_bar.dart';

class BarData {
  final double sundayAmount;
  final double mondayAmount;
  final double tuedayAmount;
  final double weddayAmount;
  final double thudayAmount;
  final double fridayAmount;
  final double satdayAmount;

  BarData({
    required this.sundayAmount,
    required this.mondayAmount,
    required this.tuedayAmount,
    required this.weddayAmount,
    required this.thudayAmount,
    required this.fridayAmount,
    required this.satdayAmount,
  });

  List<IndividualBar> barData = [];

  // Initialize barData
  void initializeBarData() {
    barData = [
      // Sunday
      IndividualBar(x: 0, y: sundayAmount),
      // Monday
      IndividualBar(x: 1, y: mondayAmount),
      // Tuesday
      IndividualBar(x: 2, y: tuedayAmount),
      // Wednesday
      IndividualBar(x: 3, y: weddayAmount),
      // Thursday
      IndividualBar(x: 4, y: thudayAmount),
      // Friday
      IndividualBar(x: 5, y: fridayAmount),
      // Saturday
      IndividualBar(x: 6, y: satdayAmount),
    ];
  }
}
