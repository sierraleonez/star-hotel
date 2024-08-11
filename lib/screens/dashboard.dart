import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salma_hotel_app/models/booking.dart';
import 'package:salma_hotel_app/screens/create_booking.dart';

final List<String> imgList = [
  'assets/hotel_1.jpg',
  'assets/hotel_2.jpg',
  'assets/hotel_3.jpg',
];

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<BookingModel>(context, listen: true);
    var stateLength = store.getLength();
    return (Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateBooking()));
        },
        backgroundColor: Color.fromRGBO(197, 112, 93, 1),
        foregroundColor: Color.fromRGBO(248, 237, 227, 1),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Dashboard'),
      ),
      body: Column(
        children: [
          // Text("hello from dashboard"),
          HotelCarousel(),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Expanded(
                  child: SizedBox(
                      height: 500,
                      child: GridView.count(
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          InfoCard(
                            label: "Total Room",
                            value: "100",
                          ),
                          InfoCard(
                            label: "Rooms Available",
                            value: "50",
                          ),
                          InfoCard(
                            label: "Total Guests",
                            value: "77",
                          ),
                          InfoCard(
                            label: "Booking Created",
                            value: stateLength.toString(),
                          ),
                        ],
                      ))))
        ],
      ),
    ));
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const InfoCard({super.key, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return (
        // width: double.maxFinite,
        Card(
      color: Color.fromRGBO(197, 112, 93, 1),
      child: SizedBox(
        // width: 100,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: Color.fromRGBO(248, 237, 227, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Text(
              value,
              style: TextStyle(
                  color: Color.fromRGBO(223, 211, 195, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 36),
            ),
          ],
        )),
      ),
    ));
  }
}

class HotelCarousel extends StatelessWidget {
  const HotelCarousel({super.key});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: imgList.map((i) {
          return Builder(builder: (BuildContext ctx) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              // decoration: BoxDecoration(color: Colors.amber),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(i, fit: BoxFit.cover, width: 1000),
                ),
              ),
            );
          });
        }).toList(),
        options: CarouselOptions(height: 200));
  }
}
