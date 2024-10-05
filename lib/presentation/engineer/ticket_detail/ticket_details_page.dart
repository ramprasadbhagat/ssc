import 'package:flutter/material.dart';
import 'package:ssc/domain/model/ticket_entity.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class TicketDetailsPage extends StatefulWidget {
  final TicketEntity ticketEntity;
  TicketDetailsPage({super.key, required this.ticketEntity});

  @override
  State<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  String _selectedStatus = 'Todo';
  late  String _previousStatus;

  // Variable to hold the selected item
  final List<String> _statusItems = [
    'Todo',
    'In Progress',
    'Pending',
    'Done',
    'Rejected'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _previousStatus = _selectedStatus;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Ticket detail'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.ticketEntity.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Text('Description -',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        SizedBox(
                          height: 4.0.h,
                        ),
                        Text(
                          widget.ticketEntity.description,
                        ),
                        SizedBox(
                          height: 12.0.h,
                        ),
                        Divider(),
                        Text('Requested Message -',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        SizedBox(
                          height: 4.0.h,
                        ),
                        Text(
                          widget.ticketEntity.requestMessage,
                        ),
                        SizedBox(
                          height: 12.0.h,
                        ),
                        Text('Requested audio -',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        SizedBox(
                          height: 4.0.h,
                        ),
                        Text(
                          widget.ticketEntity.requestMessage,
                        ),
                        SizedBox(
                          height: 12.0.h,
                        ),
                        Divider(),
                        Text('Customer Information -',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        SizedBox(
                          height: 12.0.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text('Name')),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  widget.ticketEntity.customerName,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8.0.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text('Email')),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  widget.ticketEntity.customerEmail,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8.0.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text('Address')),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  widget.ticketEntity.customerAddress,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8.0.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text('Phone Number')),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  widget.ticketEntity.customerMobileNumber,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.0.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('Select Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: _selectedStatus,
                            hint: Text('Select Status'),
                            dropdownColor: Colors.white,
                            items: _statusItems.map((String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedStatus = newValue!;
                              });
                            },
                            borderRadius: BorderRadius.circular(8),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.0.h),
                if(_previousStatus != _selectedStatus)
                  ElevatedButton(onPressed: () {}, child: Text('Update Status'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
