import 'package:flutter/material.dart';

class BookingModel extends ChangeNotifier {
  static List<BookingItem> listBooking = [];

  BookingItem getById(int id) => listBooking.firstWhere((BookingItem item) {
        return item.id == id;
      });
  List<BookingItem> getAll() {
    return listBooking.toList();
  }
  void append(BookingItem item) {
    listBooking.add(item);
    notifyListeners();
  }
  BookingItem getByIdx(int idx) {
    return listBooking[idx];
  }

  int getLength() {
    return listBooking.length;
  }
}

@immutable
class BookingItem {
  const BookingItem({required this.id, required this.checkinDate, required this.checkOutDate, required this.rate});
  final int? id;
  final DateTime checkinDate;
  final DateTime checkOutDate;
  final double rate;
}

class BookingState extends ChangeNotifier {
  late BookingModel model;
  List<BookingItem> get bookingList => model.getAll();
  void add (BookingItem item) {
    model.append(item);
    notifyListeners();
  }
}
