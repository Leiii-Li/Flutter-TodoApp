import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/theme.dart';

class AddTaskButton extends StatelessWidget {
  final String _label;
  final Function _onTap;

  AddTaskButton(this._label, this._onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryClr),
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              _label,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
