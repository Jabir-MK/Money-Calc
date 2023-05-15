import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.onDeletetap,
  });
  final String name;
  final String amount;
  final DateTime dateTime;
  final void Function(BuildContext)? onDeletetap;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // If needed we can add more buttons by this SlidableAction
          SlidableAction(
            onPressed: onDeletetap,
            icon: Icons.delete_outline_rounded,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(10),
          )
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text('${dateTime.day}/${dateTime.month}/${dateTime.year}'),
        trailing: Text('\u{20B9} $amount'),
      ),
    );
  }
}
