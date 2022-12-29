import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/theme.dart';

class CreateTaskButton extends StatelessWidget {
  final String _label;
  final Function _onTap;

  CreateTaskButton(this._label, this._onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        width: 90,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: primaryClr),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
