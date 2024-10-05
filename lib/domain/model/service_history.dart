import 'package:flutter/material.dart';

class ServiceHistory {
  final String title;
  final String description;
  final String status;

  ServiceHistory({required this.title, required this.description, required this.status});

  Color get getStatusColor {
    switch(status){
      case 'Todo':
        return Colors.grey;
      case 'In Progress':
        return Colors.orangeAccent;
      case 'Pending':
        return Colors.brown;
      case 'Done':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}