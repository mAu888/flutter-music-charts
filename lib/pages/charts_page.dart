import 'package:flutter/material.dart';

class ChartsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: index % 4 == 2 || index % 4 == 1
              ? Colors.lightBlue
              : Colors.lightGreen,
          child: Center(
            child: Text("Good $index"),
          ),
        );
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}
