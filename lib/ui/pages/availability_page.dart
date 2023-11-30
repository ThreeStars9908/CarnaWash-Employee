// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';
import '../ui.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage({super.key});

  @override
  State<AvailabilityPage> createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  void _selectTime(oldTime) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: oldTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        oldTime = newTime;
      });
    }
  }

  List isOpen = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  late TimeAvailableModel timeAvailable;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      WasherProvider washerProvider = Provider.of(context);

      await washerProvider.loadTimeAvailable(context);
      timeAvailable = washerProvider.getAllTimeAvailable();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    WasherProvider washerProvider = Provider.of(context);

    return Scaffold(
      bottomNavigationBar: navigationBarComponent(context),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          backButtonComponent(context),
                          const Text(
                            'Availability',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      notificationGeralButtonComponent(context),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set your working hours',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      timeAvailableBox(context, timeAvailable.sunday_list, 0),
                      timeAvailableBox(context, timeAvailable.monday_list, 1),
                      timeAvailableBox(context, timeAvailable.tuesday_list, 2),
                      timeAvailableBox(context, timeAvailable.wednesday_list, 3),
                      timeAvailableBox(context, timeAvailable.thursday_list, 4),
                      timeAvailableBox(context, timeAvailable.friday_list, 5),
                      timeAvailableBox(context, timeAvailable.saturday_list, 6),
                      SizedBox(height: 20),
                      TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(MediaQuery.of(context).size.width * 0.85, 50),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(237, 189, 58, 1),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await washerProvider.updateTimeAvailable(
                            context,
                            TimeAvailableProviderModel(
                              sunday_list: '${timeAvailable.sunday_list.start.hour}:${timeAvailable.sunday_list.start.minute};${timeAvailable.sunday_list.finish.hour}:${timeAvailable.sunday_list.finish.minute};${timeAvailable.sunday_list.breakpoint.hour}:${timeAvailable.sunday_list.breakpoint.minute};${timeAvailable.sunday_list.pause.hour}:${timeAvailable.sunday_list.pause.minute};',
                              monday_list: '${timeAvailable.monday_list.start.hour}:${timeAvailable.monday_list.start.minute};${timeAvailable.monday_list.finish.hour}:${timeAvailable.monday_list.finish.minute};${timeAvailable.monday_list.breakpoint.hour}:${timeAvailable.monday_list.breakpoint.minute};${timeAvailable.monday_list.pause.hour}:${timeAvailable.monday_list.pause.minute};',
                              tuesday_list: '${timeAvailable.tuesday_list.start.hour}:${timeAvailable.tuesday_list.start.minute};${timeAvailable.tuesday_list.finish.hour}:${timeAvailable.tuesday_list.finish.minute};${timeAvailable.tuesday_list.breakpoint.hour}:${timeAvailable.tuesday_list.breakpoint.minute};${timeAvailable.tuesday_list.pause.hour}:${timeAvailable.tuesday_list.pause.minute};',
                              wednesday_list: '${timeAvailable.wednesday_list.start.hour}:${timeAvailable.wednesday_list.start.minute};${timeAvailable.wednesday_list.finish.hour}:${timeAvailable.wednesday_list.finish.minute};${timeAvailable.wednesday_list.breakpoint.hour}:${timeAvailable.wednesday_list.breakpoint.minute};${timeAvailable.wednesday_list.pause.hour}:${timeAvailable.wednesday_list.pause.minute};',
                              thursday_list: '${timeAvailable.thursday_list.start.hour}:${timeAvailable.thursday_list.start.minute};${timeAvailable.thursday_list.finish.hour}:${timeAvailable.thursday_list.finish.minute};${timeAvailable.thursday_list.breakpoint.hour}:${timeAvailable.thursday_list.breakpoint.minute};${timeAvailable.thursday_list.pause.hour}:${timeAvailable.thursday_list.pause.minute};',
                              friday_list: '${timeAvailable.friday_list.start.hour}:${timeAvailable.friday_list.start.minute};${timeAvailable.friday_list.finish.hour}:${timeAvailable.friday_list.finish.minute};${timeAvailable.friday_list.breakpoint.hour}:${timeAvailable.friday_list.breakpoint.minute};${timeAvailable.friday_list.pause.hour}:${timeAvailable.friday_list.pause.minute};',
                              saturday_list: '${timeAvailable.saturday_list.start.hour}:${timeAvailable.saturday_list.start.minute};${timeAvailable.saturday_list.finish.hour}:${timeAvailable.saturday_list.finish.minute};${timeAvailable.saturday_list.breakpoint.hour}:${timeAvailable.saturday_list.breakpoint.minute};${timeAvailable.saturday_list.pause.hour}:${timeAvailable.saturday_list.pause.minute};',
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.LOGIN);
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Color.fromRGBO(237, 189, 58, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget timeAvailableBox(
    BuildContext context,
    TimeAvailableChangeModel timeAvailable,
    int index,
  ) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Color.fromRGBO(237, 189, 58, 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      color: Colors.white),
                ),
                Text(
                  timeAvailable.day,
                ),
                IconButton(
                  splashColor: Colors.white,
                  splashRadius: 10,
                  icon: Icon(!isOpen[index].isOpen
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_down),
                  onPressed: () {
                    setState(() {
                      isOpen[index].isOpen = !isOpen[index].isOpen;
                    });
                  },
                )
              ],
            ),
          ),
        ),
        isOpen[index].isOpen
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Start Time'),
                          GestureDetector(
                            onTap: () {
                              _selectTime(timeAvailable.start);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  '${timeAvailable.start.hour}:${timeAvailable.start.minute}',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Finish Time'),
                          GestureDetector(
                            onTap: () {
                              _selectTime(timeAvailable.finish);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  '${timeAvailable.finish.hour}:${timeAvailable.finish.minute}',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Break Time'),
                              GestureDetector(
                                onTap: () {
                                  _selectTime(timeAvailable.breakpoint);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Text(
                                      '${timeAvailable.breakpoint.hour}:${timeAvailable.breakpoint.minute}',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Pause Time'),
                              GestureDetector(
                                onTap: () {
                                  _selectTime(timeAvailable.pause);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Text(
                                      '${timeAvailable.pause.hour}:${timeAvailable.pause.minute}',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 16),
      ],
    );
  }
}
