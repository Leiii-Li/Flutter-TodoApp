import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final String _title;
  final String _hint;
  final TextEditingController? _controller;
  final Widget? _widget;

  InputField(this._title, this._hint, this._controller, this._widget,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            style: titleStyle,
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(left: 8),
            height: 52,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  readOnly: _widget != null,
                  autofocus: false,
                  cursorColor:
                      Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                  controller: _controller,
                  style: subTitleStyle,
                  decoration: InputDecoration(
                      hintText: _hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: context.theme.backgroundColor, width: 0)),
                      border: InputBorder.none),
                )),
                _widget == null
                    ? Container()
                    : Container(
                        child: _widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
