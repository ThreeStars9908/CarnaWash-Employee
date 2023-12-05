// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';
import '../ui.dart';

class WashRequestPage extends StatefulWidget {
  ScheduleModel? preData;

  WashRequestPage({
    super.key,
    this.preData,
  });

  @override
  State<WashRequestPage> createState() => _WashRequestPageState();
}

class _WashRequestPageState extends State<WashRequestPage> {
  ClientModel? client;
  List<CarObjectModel> carsObjectList = [];
  int page_state = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ScheduleProvider scheduleProvider = Provider.of(context, listen: false);
      ServicesProvider servicesProvider = Provider.of(context, listen: false);
      VehiclesProvider vehiclesProvider = Provider.of(context, listen: false);
      await vehiclesProvider.loadCars(context);
      await servicesProvider.loadAdditional(context);
      await servicesProvider.loadCarsize(context);
      client = await scheduleProvider.loadClient(context, widget.preData!.washer_id!);

      for (var i in widget.preData!.cars_list_id.split(';')) {
        CarObjectModel? car = await scheduleProvider.loadObjectCar(
          context,
          int.parse(i),
        );
        if (car != null) {
          carsObjectList.add(car);
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScheduleProvider scheduleProvider = Provider.of(context, listen: false);
    return (page_state == 0)?
    Scaffold(
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
                            'Wash Information',
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
                  const SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('y MMMM d h:mm a')
                            .format(widget.preData!.selected_date)
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Customer: ${client!.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Column(
                        children: List.generate(
                          carsObjectList.length,
                          (index) {
                            return requestBox(context, index);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(229, 229, 229, 1),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '\$ ${calculateTotalPrice().toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
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
                              widget.preData!.status! == 'not-started'?
                                  Color.fromRGBO(237, 189, 58, 1):
                                  Colors.grey
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if(widget.preData!.status! == 'not-started'){
                            setState(() {
                              page_state = 1;
                            });
                            setState(() async {
                              await scheduleProvider.changeStatusSchedule(
                                context,
                                widget.preData!.id!,
                              );
                            });
                          }
                        },
                        child: Text(
                          widget.preData!.status! == 'not-started'?'Accept':'Accepted',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {

                          },
                          child: const Text(
                            'Reject',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ):bookingConfirmed(context);
  }

  Widget bookingConfirmed(BuildContext context) {
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
                            'Wash Information',
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
                  const SizedBox(height: 25),
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green, // Choose the color you prefer
                          size: 80,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Booking Confirmed',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  double calculateTotalPrice() {
    double total = 0;

    for (int id = 0; id < carsObjectList.length; id++) {
      VehiclesProvider vehiclesProvider = Provider.of(context, listen: false);
      ServicesProvider servicesProvider = Provider.of(context, listen: false);

      List<CarModel> carsList = [];
      List<List<AdditionalModel>> addonList = [];

      for (var i in carsObjectList) {
        List<AdditionalModel> addonList_tm = [];
        CarModel? car = vehiclesProvider.loadOneCar(
          context,
          i.car_id,
        );
        if (car != null) {
          carsList.add(car);
        }
        for (var j in i.additional_list_id.split(';')) {
          AdditionalModel? addon =
          servicesProvider.getAdditionalComplete(int.parse(j));
          if (addon != null) {
            addonList_tm.add(addon);
          }
        }
        addonList.add(addonList_tm);
      }

      double addonPrice = addonList[id].fold<double>(
        0,
            (previousValue, addon) => previousValue + double.parse(addon.price),
      );

      // Calculate total price for each item
      double totalPrice = carsObjectList[id].wash_type == 1
          ? double.parse(servicesProvider.getCarsizeComplete(carsList[id].car_size_id).price) +
          addonPrice
          : double.parse(servicesProvider.getCarsizeComplete(carsList[id].car_size_id).price) +
          addonPrice + 40;

      // Add to the total
      total += totalPrice;
    }

    return total;
  }

  Widget requestBox(
    BuildContext context,
    int id,
  ) {
    VehiclesProvider vehiclesProvider = Provider.of(context, listen: false);
    ServicesProvider servicesProvider = Provider.of(context, listen: false);

    List<CarModel> carsList = [];
    List<List<AdditionalModel>> addonList = [];

    for (var i in carsObjectList) {
      List<AdditionalModel> addonList_tm = [];
      CarModel? car = vehiclesProvider.loadOneCar(
        context,
        i.car_id,
      );
      if (car != null) {
        carsList.add(car);
      }
      for (var j in i.additional_list_id.split(';')) {
        AdditionalModel? addon =
            servicesProvider.getAdditionalComplete(int.parse(j));
        if (addon != null) {
          addonList_tm.add(addon);
        }
      }
      addonList.add(addonList_tm);
    }
    print('carsList size' + carsList.length.toString());
    double addonPrice = addonList[id].fold<double>(
      0,
          (previousValue, addon) => previousValue + double.parse(addon.price),
    );

    // Calculate total price
    double totalPrice = carsObjectList[id].wash_type == 1 ?
        double.parse(servicesProvider.getCarsizeComplete(carsList[id].car_size_id).price) +
            addonPrice: double.parse(servicesProvider.getCarsizeComplete(carsList[id].car_size_id).price) +
        addonPrice + 40;

    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  '${carsList[id].brand} - ${carsList[id].model} - ${servicesProvider.getCarsizeComplete(carsList[id].car_size_id).title}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  carsList[id].plate,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  carsObjectList[id].wash_type == 1
                      ? 'Wash outside only'
                      : 'Wash inside & outside'
                  ,
                  style:const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: List.generate(
                    addonList[id].length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '+ ${addonList[id][index].title}, ',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      color: Color.fromRGBO(237, 189, 58, 1),
                    ),
                    Text(
                      widget.preData!.address,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your earnings',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '\$ ${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Costumer's comments",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Text(widget.preData!.observation_address),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
