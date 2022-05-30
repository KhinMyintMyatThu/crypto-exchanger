import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// This is the stateful widget that the main application instantiates.
class DropDownWidget extends StatefulWidget {
  final Function(String?)? onChangedCallback;
  final String? dropdownValue;
  final List<String?> valueList;

  DropDownWidget(
      {Key? key,
      required this.onChangedCallback,
      required this.dropdownValue,
      required this.valueList});

  @override
  State<DropDownWidget> createState() => _DropDownWidget();
}

class _DropDownWidget extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 5.h,
        width: 50.w,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          value: widget.dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.black87,
            size: 35,
          ),
          elevation: 16,
          style: TextStyle(
              color: Colors.black, fontSize: 11.0.sp, fontFamily: 'Roboto'),
          isExpanded: true,
          underline: Container(
            height: 1,
            color: Colors.white,
          ),
          onChanged: widget.onChangedCallback,
          items: widget.valueList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value!),
            );
          }).toList(),
        )));
  }
}
