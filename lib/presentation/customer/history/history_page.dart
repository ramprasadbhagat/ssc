import 'package:flutter/material.dart';
import 'package:ssc/domain/model/service_history.dart';
import 'package:ssc/presentation/common/no_record_found.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final List<ServiceHistory> serviceHistoryList = [
    ServiceHistory(title: 'Service 1', description: 'Description 1', status: 'In Progress'),
    ServiceHistory(title: 'Service 2', description: 'Description 2', status: 'Done'),
    ServiceHistory(title: 'Service 3', description: 'Description 3', status: 'Pending'),
    ServiceHistory(title: 'Service 4', description: 'Description 4', status: 'Rejected'),
    ServiceHistory(title: 'Service 5', description: 'Description 5', status: 'Todo'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('History'),
        centerTitle: true,
        leading: SizedBox.shrink(),
      ),
      body: serviceHistoryList.isNotEmpty ? ListView.builder(itemCount: serviceHistoryList.length, itemBuilder: (context, i){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8 ),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 2)
                  ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text(serviceHistoryList[i].title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: serviceHistoryList[i].getStatusColor,
                  ),
                  child: Text((serviceHistoryList[i].status), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                ),
              ],),
              Text(serviceHistoryList[i].description)
            ],
          ),
        );
      }) : NoRecordFound(title: 'No service requested'),
    );
  }
}