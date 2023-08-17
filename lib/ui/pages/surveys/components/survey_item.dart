import 'package:flutter/material.dart';

class SurveyItem extends StatelessWidget {
  const SurveyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow> [
          BoxShadow(
            offset: Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2,
            color: Colors.black,
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text(
            '16 ago 2023',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Pegunta placeholder',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24
            ),
          ),
        ],
      )
    );
  }
}
