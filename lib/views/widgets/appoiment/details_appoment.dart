  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:teledocuser/const/const.dart';
  import 'package:teledocuser/controllers/appoiment/appoimnet_controller.dart';
  import 'package:teledocuser/controllers/payment/payment.dart';
  import 'package:teledocuser/controllers/time/datecontroller.dart';
  import 'package:teledocuser/controllers/time/time_controller.dart';
  import 'package:teledocuser/views/widgets/appoiment/payment_card.dart';

  class AllSelctedDetailsForAppoiment extends GetView<PaymentController> {
    AllSelctedDetailsForAppoiment({super.key});
    final AppointmentController appointmentController =
        Get.put(AppointmentController());
    final DateController dateController = Get.put(DateController());
    final TimeSlotPickerController timecontroller =
        Get.put(TimeSlotPickerController());

    @override
    Widget build(BuildContext context) {
        final selectedTime =  timecontroller.selectTime.value;
      return Column(
        children: [
        const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      ' Details',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PaymentAndDeatilsCardWidget(),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name                             : ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              appointmentController.nameController.text,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reson For Appoiment : ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              appointmentController.reasonController.text,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Nomber           : ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              appointmentController.contactController.text,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date                                 : ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                                dateController.selectedDate.value
                                    .toString()
                                    .split(" ")
                                    .first,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Time                                : ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              _formatTime(selectedTime!),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(
                              8),
                        ),
                        child: TextButton(
                          onPressed: () {
                            controller.openCheckout();
                          },
                          child: const Text(
                            "Book an Appointment",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
      String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour < 10 ? "0$hour" : hour}:$minute $period';
  }
  }
