import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ssc/domain/model/engineer/enginner_info.dart';
import 'package:ssc/presentation/utils/common/custom_snackbar.dart';

class EngineerReviewPage extends StatefulWidget {
  @override
  _EngineerReviewPageState createState() => _EngineerReviewPageState();
}

class _EngineerReviewPageState extends State<EngineerReviewPage> {
  final List<EngineerInfo> servicePersons = [
    EngineerInfo(name: 'John Doe', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '1'),
    EngineerInfo(name: 'Jane Smith', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '2'),
    EngineerInfo(name: 'Mike Johnson', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '3'),
    EngineerInfo(name: 'Alice Williams', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '4'),
    EngineerInfo(name: 'John Smith', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '5'),
    EngineerInfo(name: 'Travis Doe', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '6'),
    EngineerInfo(name: 'John Doe', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '1'),
    EngineerInfo(name: 'Jane Smith', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '2'),
    EngineerInfo(name: 'Mike Johnson', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '3'),
    EngineerInfo(name: 'Alice Williams', rating: 0, address: 'abc',password: '', phoneNumber: '7080', id: '4'),
  ];

  void _submitForm(EngineerInfo engineerInfo) {
    if(engineerInfo.rating == 0){
      CustomSnackbar.showSuccessMessage(context, 'Please do Rating for ${engineerInfo.name} first');
    return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rating submitted for ${engineerInfo.name}: ${engineerInfo.rating}'), backgroundColor: Colors.green.shade300,),
    );
    setState(() {
      servicePersons.remove(engineerInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share your Ratings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: (){},
              title: Text(
              'Tap to get update for new reviews',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
            trailing: Icon(Icons.refresh),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: servicePersons.length,
                itemBuilder: (context, index) {
                  final servicePerson = servicePersons[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rate for ${servicePerson.name}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          RatingBar.builder(
                            initialRating: servicePerson.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                servicePersons[index] = servicePerson.copyWith(
                                  rating: rating,
                                );
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => _submitForm(servicePerson),
                            child: Text('Submit Rating'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
