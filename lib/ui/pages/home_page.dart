// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';
import '../ui.dart';

class HomePage extends StatefulWidget {

  const HomePage({
    Key? key,
    this.validate = true,
  }) : super(key: key);

  final bool validate;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late int allWashes;
  late int nextWashes;
  late int cancelWashes;
  late ScheduleModel? scheduleOngoing;
  late WasherProvider washerProvider;
  late ScheduleProvider scheduleProvider;
  late ServicesProvider servicesProvider;
  late List<ScheduleModel?> listScheduleOnging;
  @override
  void initState() {
    super.initState();
    washerProvider = Provider.of(
      context,
      listen: false,
    );
    servicesProvider = Provider.of(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      scheduleProvider = Provider.of(
        context,
        listen: false,
      );

      await washerProvider.loadWasherInfo(context);
      await scheduleProvider.loadSchedules(context, DateTime.now());
      allWashes = await scheduleProvider.countAll(context);
      nextWashes = await scheduleProvider.countNext(context);
      cancelWashes = await scheduleProvider.countCancel(context);

      await servicesProvider.loadCarsize(context);

      await scheduleProvider.loadOngoing(context);
      listScheduleOnging =scheduleProvider.listSchedulesOngoing;
          print('listScheduleOnging' + listScheduleOnging.length.toString());
      // Call setState to rebuild the widget tree with the updated values
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: widget.validate
          ? navigationBarComponent(context)
          : TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            color: Color.fromRGBO(237, 189, 58, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            notificationHomeButtonComponent(context),
                            Row(
                              children: [
                                const Text(
                                  'Welcome, ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${userProvider.perfil.name}!',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )

                          ],
                        ),
                        const Image(
                          width: 125,
                          image: AssetImage('images/logo.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            widget.validate ? validatedTrue(context) : validatedFalse(context),
          ],
        ),
      ),
    );
  }

  Widget validatedTrue(BuildContext context){
    if (washerProvider.washerInfo == null) {
      // Display a loading state or return an empty widget
      return CircularProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Text(
            'Your rate',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          RatingBarIndicator(
            rating: washerProvider.washerInfo.rate!,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Color.fromRGBO(237, 189, 58, 1),
            ),
            itemCount: 5,
            itemSize: 40,
            direction: Axis.horizontal,
          ),
          const SizedBox(height: 24),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(children: [
                  const Text(
                    'Number of Washes',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    allWashes.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 28,
                    ),
                  ),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.42,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(children: [
                    const Text(
                      'Next scheduled',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      nextWashes.toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 28,
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.42,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(children: [
                    const Text(
                      'Canceled washes',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      cancelWashes.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 28,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          scheduleProvider.verifyUnaccepted()
              ? Container(
            padding: const EdgeInsets.all(24),
            height: 72,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(229, 229, 229, 1),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: const Row(
              children: [
                Icon(Icons.report_outlined),
                Text(
                  'You have a wash request',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
              : const SizedBox(),
          const SizedBox(height: 24),
          Column(
              children: List.generate(
                listScheduleOnging.length,
                    (index) {
                  return WashingProcessBlock(
                    scheduleModel: listScheduleOnging[index]!,
                  );
                },
              )),
        ],
      ),
    );
  }

  Widget validatedFalse(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(16, 126, 196, 0.2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: const Iconify(
                    Ri.loader_2_fill,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Your information is processing',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'We have received you information.',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'You will receive a notification via the app once you access is activate',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class WashingProcessBlock extends StatefulWidget {
  late ScheduleModel scheduleModel;


  WashingProcessBlock({
    Key? key,
    required ScheduleModel scheduleModel,
  }) : super(key: key) {
    this.scheduleModel = scheduleModel;
  }

  @override
  State<WashingProcessBlock> createState() => _WashingProcessBlockState();
}

class _WashingProcessBlockState extends State<WashingProcessBlock> {
  List<CarModel?> carsList = [];
  List<CarObjectModel?> carsObjectList = [];
  List addonList = [];
  late ClientModel? client;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ScheduleProvider scheduleProvider = Provider.of(context, listen: false);
      ServicesProvider servicesProvider_second = Provider.of(context, listen: false);
      VehiclesProvider vehiclesProvider = Provider.of(context, listen: false);
      await vehiclesProvider.loadCars(context);
      client = await scheduleProvider.loadClient(
        context,
        widget.scheduleModel.washer_id!,
      );
      for (var i in widget.scheduleModel.cars_list_id.split(';')) {
        print(i);
        CarObjectModel? car = await scheduleProvider.loadObjectCar(
          context,
          int.parse(i),
        );
        if (car != null) {
          carsObjectList.add(car);
        }
        print('home___' + car!.additional_list_id);
        for (var j in car!.additional_list_id.split(';')) {
          AdditionalModel? addon =
          servicesProvider_second.getAdditionalComplete(int.parse(j));
          if (addon != null) {
            addonList.add(addon);
          }
        }
      }
      for (var i in carsObjectList) {
        CarModel? car = vehiclesProvider.loadOneCar(
          context,
          i!.car_id,
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
    ServicesProvider servicesProvider_third = Provider.of(context, listen: false);
    if (client == null) {
      // Display a loading state or return an empty widget
      return CircularProgressIndicator();
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Washing Process:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('yMMMMd')
                            .format(widget.scheduleModel.selected_date)
                            .toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        DateFormat('jm')
                            .format(widget.scheduleModel.selected_date)
                            .toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Client: ${client!.name}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Column(
                    children: List.generate(
                      carsList.length,
                          (indexCar) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${carsList[indexCar]!.brand} - ${carsList[indexCar]!.model} - ${servicesProvider_third.getCarsizeComplete(carsList[indexCar]!.car_size_id).title}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            carsList[indexCar]!.plate,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            servicesProvider_third
                                .getCarsizeComplete(
                                carsList[indexCar]!.car_size_id)
                                .title,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
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
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(
                          MediaQuery.of(context).size.width * 0.85,
                          50,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        widget.scheduleModel.status == 'not-started'
                            ? Colors.green
                            : widget.scheduleModel.status == 'not-accepted'
                            ? Colors.yellow
                            : Colors.blue,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() async {
                        await scheduleProvider.changeStatusSchedule(
                          context,
                          widget.scheduleModel.id!,
                        );
                      });
                    },
                    child: Text(
                        widget.scheduleModel.status == 'not-started'
                          ? 'Start'
                          : widget.scheduleModel.status == 'not-accepted'
                          ? 'Accept'
                          : 'Finished',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WashRequestPage(
                              preData: widget.scheduleModel,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'View more information',
                        style: TextStyle(
                          color: Color.fromRGBO(237, 189, 58, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
