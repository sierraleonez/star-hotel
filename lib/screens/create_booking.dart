import 'dart:math';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:salma_hotel_app/models/booking.dart';
import 'package:signature/signature.dart';

class CreateBooking extends StatefulWidget {
  const CreateBooking({super.key});

  @override
  CreateBookingState createState() {
    return CreateBookingState();
  }
}

class CreateBookingState extends State<CreateBooking> {
  DateTime? selectedDate;
  DateTime? selectedCheckOutDate;
  double rate = 0;

  final _formKey = GlobalKey<FormState>();
  var currentDate = DateTime.now();
  SignatureController controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.white,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Booking"),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DateTimeField(
                      value: selectedDate,
                      firstDate: currentDate,
                      lastDate: DateTime(currentDate.year, currentDate.month,
                          currentDate.day + 30),
                      decoration: const InputDecoration(
                        labelText: 'Check-In Date',
                        border: OutlineInputBorder(),
                        helperText: 'YYYY/MM/DD',
                      ),
                      dateFormat: DateFormat.yMd(),
                      mode: DateTimeFieldPickerMode.date,
                      pickerPlatform: DateTimeFieldPickerPlatform.adaptive,
                      onChanged: (DateTime? value) {
                        setState(() {
                          selectedDate = value;
                        });
                      }),
                  SizedBox(height: 20),
                  DateTimeField(
                      firstDate: selectedDate == null
                          ? currentDate
                          : DateTime(selectedDate!.year, selectedDate!.month,
                              selectedDate!.day + 1),
                      lastDate: DateTime(currentDate.year, currentDate.month,
                          currentDate.day + 30),
                      value: selectedCheckOutDate,
                      decoration: const InputDecoration(
                        labelText: 'Check-Out Date',
                        border: OutlineInputBorder(),
                        helperText: 'YYYY/MM/DD',
                      ),
                      dateFormat: DateFormat.yMd(),
                      mode: DateTimeFieldPickerMode.date,
                      pickerPlatform: DateTimeFieldPickerPlatform.adaptive,
                      onChanged: (DateTime? value) {
                        setState(() {
                          selectedCheckOutDate = value;
                        });
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                    inputFormatters: [DecimalFormatter(decimalDigits: 2)],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Rate',
                        prefix: Text('Rp.'),
                        label: Text('Rate')),
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Rate is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Signature',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.start,
                      )),
                  Signature(
                    controller: controller,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      final booking = BookingModel();
                      // print(_formKey.currentState)
                      var isCheckInEmpty = selectedDate == null;
                      var isCheckOutEmpty = selectedCheckOutDate == null;
                      var isFormValid = !isCheckInEmpty && !isCheckOutEmpty && _formKey.currentState!.validate();
                      if (isFormValid) {
                        print("form valid");
                        booking.append(BookingItem(
                          id: Random().nextInt(100),
                          checkinDate: selectedDate ?? currentDate,
                          checkOutDate: selectedCheckOutDate ?? currentDate,
                          rate: rate
                        ));
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(197, 112, 93, 1),
                        elevation: 0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: const Color.fromRGBO(248, 237, 227, 1)),
                    ),
                  )
                ],
              ),
            )));
  }
}

class DecimalFormatter extends TextInputFormatter {
  final int decimalDigits;

  DecimalFormatter({this.decimalDigits = 2}) : assert(decimalDigits >= 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText;

    if (decimalDigits == 0) {
      newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    } else {
      newText = newValue.text.replaceAll(RegExp('[^0-9\.]'), '');
    }

    if (newText.contains('.')) {
      //in case if user's first input is "."
      if (newText.trim() == '.') {
        return newValue.copyWith(
          text: '0.',
          selection: TextSelection.collapsed(offset: 2),
        );
      }
      //in case if user tries to input multiple "."s or tries to input
      //more than the decimal place
      else if ((newText.split(".").length > 2) ||
          (newText.split(".")[1].length > this.decimalDigits)) {
        return oldValue;
      } else {
        return newValue;
      }
    }

    //in case if input is empty or zero
    if (newText.trim() == '' || newText.trim() == '0') {
      return newValue.copyWith(text: '');
    } else if (int.parse(newText) < 1) {
      return newValue.copyWith(text: '');
    }

    double newDouble = double.parse(newText);
    var selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    String newString = NumberFormat("#,##0.##").format(newDouble);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
