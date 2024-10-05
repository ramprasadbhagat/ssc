
import 'package:flutter/material.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class NoRecordFound extends StatelessWidget {
  final String title;
  const NoRecordFound({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.plagiarism_rounded, size: 100, color: Colors.grey,),
                SizedBox(height: 10.0.h,),
                Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                  ),
              ],
            );
  }
}