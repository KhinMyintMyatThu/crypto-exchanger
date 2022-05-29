import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeCardWidget extends StatelessWidget {
  final FlagsCode? flagCode;
  final String? currencyName;
  final String? longTerm;
  final dynamic price;
  final dynamic changedPrice;

  const HomeCardWidget(
      {Key? key,
      this.flagCode,
      this.currencyName,
      this.longTerm,
      this.price,
      this.changedPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
            width: double.infinity,
            height: 15.h,
            decoration:
                BoxDecoration(color: Colors.grey.shade50 ,borderRadius: BorderRadius.circular(30.0)),
            child: Row(
              children: [
                SizedBox(width: 5.w),
                Flag.fromCode(
                  flagCode!,
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                  flagSize: FlagSize.size_1x1,
                  borderRadius: 25,
                ),
                SizedBox(width: 5.w),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currencyName!,
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(longTerm!)
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                SizedBox(
                  width: 5.w,
                )
              ],
            )),
      ),
    );
  }
}
