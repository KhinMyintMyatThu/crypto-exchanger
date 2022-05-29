import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Shimmer.fromColors(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              width: 300.0 - (index * 20),
              height: 25.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
            );
          }),
        ),
        baseColor: Colors.black12,
        highlightColor: Colors.white,
        loop: 3,
      ),
    );
  }
}
