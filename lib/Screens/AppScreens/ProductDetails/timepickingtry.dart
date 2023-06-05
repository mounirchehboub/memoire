/*
 showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: height * 0.35,
                                  child: CupertinoDatePicker(
                                      backgroundColor: Colors.white,
                                      use24hFormat: true,
                                      mode: CupertinoDatePickerMode.date,
                                      minimumDate: DateTime(2023, 05, 24),
                                      initialDateTime: DateTime(2023, 05, 25),
                                      onDateTimeChanged:
                                          (DateTime userLastDate) {
                                        setState(() {
                                          endDateTime = userLastDate;
                                        });
                                      }),
                                );
                              });
 */

/*
What should i add to the cart
1 first of all the product it self
2 start Rent day/hour in String to be sent later on via email
3 End Rent day/hour in String to be sent later on via email
4 difference between end Day and start Day in an Int to calculate the price of it and add it to totalPrice

 */

/*

 bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(endDateTime))) {
      return true;
    }
    return false;
  }

  bool _decideWhichDayisToEnable(DateTime day) {
    if ((day.isAfter(startDateTime.subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 90))))) {
      return true;
    }
    return false;
  }

  _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null && picked != startDateTime) {
      setState(() {
        startDateTime = picked;
      });
    }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDateTime, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayisToEnable,
    );
    if (picked != null && picked != endDateTime) {
      setState(() {
        endDateTime = picked;
      });
    }
  }



 */

/*
hours


  _selectStartHour(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != startDateTime) {
      setState(() {
        startHourTime = picked;
      });
    }
  }

  _selectEndHour(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDateTime, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayisToEnable,
    );
    if (picked != null && picked != endDateTime) {
      setState(() {
        endDateTime = picked;
      });
    }
  }
 */
