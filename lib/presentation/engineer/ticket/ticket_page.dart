import 'package:flutter/material.dart';
import 'package:ssc/domain/model/ticket_entity.dart';
import 'package:ssc/presentation/common/no_record_found.dart';
import 'package:ssc/presentation/routes/routes_path.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  List<TicketEntity> ticketList = [
    TicketEntity(
      title: 'Ticket 1',
      description: 'This is a ticket description, This is a ticket description, This is a ticket description, This is a ticket description, This is a ticket description, This is a ticket description, ',
      status: 'Todo',
      customerName: 'Ram Prasad Bhagat',
      requestMessage: 'please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, please fix my wiring, ',
      customerAddress: 'Harzinder Road, Rabindra pally North 24 pgs',
      customerEmail: 'ram@example.com',
      customerMobileNumber: '7980708667',
    ),

    TicketEntity(
      title: 'Ticket 2',
      description: 'This is a description',
      status: 'Todo',
      customerName: 'Narayan Bhagat',
      requestMessage: 'please fix my board',
      customerAddress: 'Harzinder Road, Rabindra pally North 24 pgs',
      customerEmail: 'narayan@example.com',
      customerMobileNumber: '7980708667',
    ),
  ];

  int? _selectedIndex;

  bool get isSelected => _selectedIndex == null || _selectedIndex == -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tickets'),
        centerTitle: true,
      ),
      floatingActionButton: ticketList.isNotEmpty
          ? InkWell(
              onTap: () => isSelected
                  ? null
                  : Navigator.pushNamed(
                      context, RoutePath.engineerTicketDetailsPage,
                      arguments: ticketList[_selectedIndex ?? 0]),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      ? Colors.grey.shade300
                      : Colors.orange.shade300,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Next',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
            )
          : SizedBox.shrink(),
      body: Center(
        child: ticketList.isNotEmpty
            ? ListView.builder(
                itemCount: ticketList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: _selectedIndex == index
                              ? Colors.orange.withOpacity(0.2)
                              : Colors.grey,
                          width: 2),
                      borderRadius: BorderRadius.circular(8),
                      color: _selectedIndex == index
                          ? Colors.orange.withOpacity(0.2)
                          : Colors.white,
                    ),
                    child: ListTile(
                      title: Text(ticketList[index].title),
                      trailing: _selectedIndex == index
                          ? const Icon(Icons.check_circle,
                              color: Colors.orangeAccent)
                          : const Icon(Icons.radio_button_unchecked,
                              color: Colors.grey),
                      onTap: () {
                        setState(() {
                          if (_selectedIndex == index) {
                            _selectedIndex =
                                null; // Unselect if already selected
                          } else {
                            _selectedIndex =
                                index; // Select the tapped ListTile
                          }
                        });
                      },
                    ),
                  );
                },
              )
            : NoRecordFound(title: 'No Ticket are available'),
      ),
    );
  }
}
