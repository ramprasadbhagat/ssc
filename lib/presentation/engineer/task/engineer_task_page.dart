import 'package:flutter/material.dart';
import 'package:ssc/presentation/routes/routes_path.dart';
import 'package:ssc/presentation/utils/number_ext.dart';

class EngineerTaskPage extends StatelessWidget {
  EngineerTaskPage({super.key});

  final List<String> items = List<String>.generate(5, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.0.h, left: 5.0.w, bottom: 5.0.h),
              child: Text(
                'Available Tasks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
                child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                crossAxisSpacing: 4.0, // Horizontal space between items
                mainAxisSpacing: 4.0, // Vertical space between items
                childAspectRatio: 3 / 2, // Aspect ratio of each item
              ),
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, RoutePath.engineerTicketPage),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              'Todo',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text('10'),
                            ),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, RoutePath.engineerTicketPage),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              'In Progress',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text('1'),
                            ),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, RoutePath.engineerTicketPage),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text('1'),
                            ),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, RoutePath.engineerTicketPage),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              'Done',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text('2'),
                            ),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, RoutePath.engineerTicketPage),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              'Rejected',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text('0'),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            )),
          ],
        ),
      ),
    
    );
  }
}
