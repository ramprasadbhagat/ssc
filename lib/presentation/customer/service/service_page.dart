import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ssc/application/customer/service_detail_request/service_detail_request_bloc.dart';
import 'package:ssc/application/customer/service_list/service_list_bloc.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/presentation/common/no_record_found.dart';
import 'package:ssc/presentation/routes/routes_path.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  int? _selectedIndex;

  bool get notSelected => _selectedIndex == null || _selectedIndex == -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceListBloc, ServiceListState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        final serviceList = state.serviceEntityList;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Service'),
            centerTitle: true,
          ),
          floatingActionButton: serviceList.isNotEmpty
              ? InkWell(
                  onTap: () {
                    if (notSelected) return null;
                    context
                        .read<ServiceDetailRequestBloc>()
                        .add(ServiceDetailRequestInitialEvent(
                          customerInfo: CustomerInfo.empty(),
                          serviceEntity: serviceList[_selectedIndex ?? 0],
                        ));
                    Navigator.pushNamed(
                        context, RoutePath.customerServiceDetailPage,
                        arguments: serviceList[_selectedIndex ?? 0]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: notSelected
                          ? Colors.grey.shade300
                          : Colors.orange.shade300,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
            child: serviceList.isNotEmpty
                ? ListView.builder(
                    itemCount: serviceList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
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
                          title: Text(serviceList[index].title),
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
                : NoRecordFound(title: 'No Service are available'),
          ),
        );
      },
    );
  }
}
