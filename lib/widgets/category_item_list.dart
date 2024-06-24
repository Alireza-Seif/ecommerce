import 'package:flutter/material.dart';

class CategoryHorizontaltemList extends StatelessWidget {
  const CategoryHorizontaltemList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 75,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: ShapeDecoration(
                        color: Colors.blue,
                        shadows: const [
                          BoxShadow(
                              color: Colors.blue,
                              blurRadius: 20,
                              spreadRadius: -10,
                              offset: Offset(0, 10))
                        ],
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.mouse,
                      color: Colors.white,
                      size: 32,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'همه',
                  style: TextStyle(fontFamily: 'SB', fontSize: 12),
                )
              ],
            );
          }),
    );
  }
}
