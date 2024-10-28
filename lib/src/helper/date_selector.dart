import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({
    super.key,
    this.selectedDate1,
    this.selectedDate2,
    this.mode = 1,
  });
  final DateTime? selectedDate1;
  final DateTime? selectedDate2;
  final int mode;
  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? selectedDate1;
  DateTime? selectedDate2;
  final now = DateTime.now();
  int mode = 1;
  final DateFormat formatter = DateFormat('d MMM yyyy');
  bool date1Selected = false;
  bool date2Selected = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedDate1 != null) {
      selectedDate1 = widget.selectedDate1;
      date1Selected = true;
    }
    if (widget.selectedDate2 != null) {
      selectedDate2 = widget.selectedDate2;
      date2Selected = true;
    }
    mode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 30),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mode == 1
                                  ? Colors.blueAccent
                                  : Theme.of(context).secondaryHeaderColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            setState(() {
                              mode = 1;
                            });
                          },
                          child: Text(
                            date1Selected
                                ? formatter.format(selectedDate1 ?? now)
                                : "No Date",
                            style: TextStyle(
                                color: mode == 1
                                    ? Colors.white
                                    : Colors.blueAccent),
                          )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mode == 2
                                ? Colors.blueAccent
                                : Theme.of(context).secondaryHeaderColor,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        onPressed: () {
                          setState(() {
                            mode = 2;
                          });
                        },
                        child: Text(
                          date2Selected
                              ? formatter.format(selectedDate2 ?? now)
                              : "No Date",
                          style: TextStyle(
                              color:
                                  mode == 2 ? Colors.white : Colors.blueAccent),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CalendarDatePicker(
                initialDate: mode == 1 ? selectedDate1 : selectedDate2,
                firstDate: mode == 2 && selectedDate1 != null
                    ? (selectedDate1 ?? now)
                    : DateTime(2023),
                lastDate: mode == 1 && selectedDate2 != null
                    ? (selectedDate2 ?? now)
                    : DateTime(2123),
                onDateChanged: (DateTime date) {
                  setState(() {
                    if (mode == 1) {
                      selectedDate1 = date;
                      date1Selected = true;
                    }
                    if (mode == 2) {
                      selectedDate2 = date;
                      date2Selected = true;
                    }
                    setState(() {});
                  });
                },
              ),
              const SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 12,
                            ),
                            const Icon(
                              Icons.event,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(date1Selected
                                ? date2Selected
                                    ? "${formatter.format(selectedDate1 ?? now)} - ${formatter.format(selectedDate2 ?? now)}"
                                    : formatter.format(selectedDate1 ?? now)
                                : "No date"),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            Navigator.pop(context, {
                              "date1": selectedDate1,
                              "date2": selectedDate2,
                            });
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
