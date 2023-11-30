// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';
import '../ui.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  DateTime today = DateTime.now();
  late ScheduleProvider scheduleProvider;
  late List<ScheduleModel?> listSchedule;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      scheduleProvider = Provider.of(
        context,
        listen: false,
      );

      await scheduleProvider.loadSchedules(context, DateTime.now());
      listSchedule = scheduleProvider.listSchedules;
      setState(() {});
    });
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() async {
      today = day;
      await scheduleProvider.loadSchedules(context, day);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('schedule length' + scheduleProvider.listSchedules.length.toString());
    return Scaffold(
      backgroundColor: Colors.grey[100]!,
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
                            'My bookings',
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
                  TableCalendar(
                    locale: 'pt_BR',
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    firstDay: DateTime.utc(2010, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: today,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    onDaySelected: _onDaySelected,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Booking date:',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: List.generate(
                      scheduleProvider.listSchedules.length,
                      (index) {
                        return ScheduleBox(
                          schedule: scheduleProvider.listSchedules[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleBox extends StatefulWidget {
  late ScheduleModel schedule;

  ScheduleBox({Key? key, required ScheduleModel schedule}) : super(key: key) {
    this.schedule = schedule;
  }
  @override
  State<ScheduleBox> createState() => _ScheduleBoxState();
}

class _ScheduleBoxState extends State<ScheduleBox> {
  List<CarModel> carsList = [];
  List<CarObjectModel> carsObjectList = [];
  List<AdditionalModel> addonList = [];

  late ClientModel? client;

  List status = [
    'Accept',
    const Color.fromRGBO(237, 189, 58, 1),
    'Reject',
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ScheduleProvider scheduleProvider = Provider.of(context, listen: false);
      ServicesProvider servicesProvider = Provider.of(context, listen: false);
      VehiclesProvider vehiclesProvider = Provider.of(context, listen: false);
      await vehiclesProvider.loadCars(context);
      client = await scheduleProvider.loadClient(context, widget.schedule.washer_id!);

      for (var i in widget.schedule.cars_list_id.split(';')) {
        CarObjectModel? car = await scheduleProvider.loadObjectCar(
          context,
          int.parse(i),
        );
        if (car != null) {
          carsObjectList.add(car);
        }
        for (var j in car!.additional_list_id.split(';')) {
          AdditionalModel? addon =
              servicesProvider.getAdditionalComplete(int.parse(j));
          if (addon != null) {
            addonList.add(addon);
          }
        }
      }
      for (var i in carsObjectList) {
        CarModel? car = vehiclesProvider.loadOneCar(
          context,
          i.car_id,
        );
        if (car != null) {
          carsList.add(car);
        }
      }
      print(carsList);
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScheduleProvider scheduleProvider = Provider.of(context, listen: false);
    ServicesProvider servicesProvider = Provider.of(context, listen: false);

    if (status.isNotEmpty) {
      if (status[0] == 'accepted') {
        status = [
          'Accepted',
          Colors.grey,
          '',
        ];
      } else if (status[0] == 'start') {
        status = [
          'Start',
          Colors.green,
          '',
        ];
      } else if (status[0] == 'finish') {
        status = [
          'Finish',
          Colors.blue,
          '',
        ];
      }
    }
    if (client == null) {
      // Display a loading state or return an empty widget
      return CircularProgressIndicator();
    }
    return
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: 16,
                  top: 8,
                ),
                child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Costumer: ${client!.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormat('yMMMMd')
                                        .format(widget.schedule.selected_date)
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('jm')
                                        .format(widget.schedule.selected_date)
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.all(0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WashRequestPage(
                                    preData: widget.schedule,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'View',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${carsList[0].brand} - ${carsList[0].model} - ${servicesProvider.getCarsizeComplete(carsList[0].car_size_id).title}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(carsList[0].plate,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 16,
                                      color: Color.fromRGBO(237, 189, 58, 1),
                                    ),
                                    Text(
                                      widget.schedule.address,
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: List.generate(
                                    addonList.length,
                                    (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          '${addonList[index]}; ',
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.schedule.status != 'cancel',
                        child: TextButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            fixedSize: MaterialStateProperty.all<Size>(
                              Size(MediaQuery.of(context).size.width * 0.85, 50),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              widget.schedule.status == 'not-started'
                                  ? Colors.green
                                  : widget.schedule.status == 'not-accepted'
                                  ? Colors.amber
                                  : Colors.blue,
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          child: Text(
                            widget.schedule.status == 'not-started'
                                ? 'Start'
                                : widget.schedule.status == 'not-accepted'
                                ? 'Accept'
                                : 'Finish',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Visibility(
                    visible: widget.schedule.status != 'finished',
                    child:
                    widget.schedule.status == 'cancel'?
                    status[2] != ''
                        ? InkWell(
                      onTap: () {
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          'This booking has been cancelled',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                        : const SizedBox(height: 16):InkWell(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Decline confirmation'),
                            content: const Text(
                                'Are you sure that you want to decline this wash?'),
                            actions: [
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () async {
                                  await scheduleProvider.declineSchedule(
                                      context, widget.schedule.id!);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          widget.schedule.status == 'not-started'
                              ? 'Cancel':'Reject',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ),
                  )
                ],
              ),
            ),
          )
        ]);
  }
}
