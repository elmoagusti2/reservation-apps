import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:reservation_apps/app/common/constants/colors.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/models/field_soccer/field_soccer.dart';
import 'package:reservation_apps/app/models/transaction.dart';
import 'package:reservation_apps/app/modules/transactionPage/views/transaction_page_view.dart';
import 'package:reservation_apps/app/modules/widgets/bottom_sheet_widget.dart';
import 'package:reservation_apps/app/modules/widgets/button_widget.dart';
import 'package:reservation_apps/app/modules/widgets/separator_widget.dart';
import 'package:reservation_apps/app/modules/widgets/typography.dart';
import 'package:time_range/time_range.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  final FieldSoccer data;
  DetailPageView({required this.data, Key? key}) : super(key: key);
  final f = DateFormat('yyyy MMMM dd, EEEE');

  @override
  Widget build(BuildContext context) {
    final detailC = Get.put(DetailPageController());
    detailC.updateDate(detailC.f.format(detailC.datePick.value), data.id);
    return Scaffold(
      body: Obx(
        () => Container(
          decoration: const BoxDecoration(color: ConstColors.dark50),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: false,
                snap: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                expandedHeight: 200,
                title: Heading.h4Default(data.nama ?? ''),
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  fit: BoxFit.cover,
                  data.picturePath ?? '',
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset(
                            'assets/lottie/error.json',
                            height: 100,
                          ),
                          const Heading.h5Small(
                            'Images Error',
                            color: ConstColors.red40,
                          )
                        ],
                      ),
                    );
                  },
                )),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Heading.h5Small('Description',
                                color: ConstColors.white),
                            FilterChip(
                              label: Heading.h5Small(data.kategori ?? '',
                                  color: ConstColors.customRed),
                              backgroundColor: Colors.transparent,
                              shape: const StadiumBorder(side: BorderSide()),
                              onSelected: (bool value) {},
                            ),
                          ],
                        ),
                        Paragraph.dflt(data.description ?? '',
                            color: ConstColors.white),
                        SeparatorWidget.height24(),
                        const Heading.h5Small('Price',
                            color: ConstColors.white),
                        SeparatorWidget.height12(),
                        price(),
                        SeparatorWidget.height24(),
                        CalendarTimeline(
                          initialDate: detailC.datePick.value,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(detailC.datePick.value.year + 2),
                          onDateSelected: (date) {
                            detailC.updateDate(detailC.f.format(date), data.id);
                            detailC.datePick.value = date;
                            if (date.weekday == 6 || date.weekday == 7) {
                              detailC.weekEnd.value = true;
                            } else {
                              detailC.weekEnd.value = false;
                            }
                          },
                          leftMargin: 20,
                          monthColor: ConstColors.customRed20,
                          dayColor: ConstColors.customRed20,
                          dayNameColor: ConstColors.white,
                          activeDayColor: Colors.white,
                          activeBackgroundDayColor: ConstColors.customRed,
                          dotsColor: ConstColors.white,
                        ),
                      ],
                    ),
                  ),
                  SeparatorWidget.height32(),
                  GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.0,
                      children: List.generate(detailC.dateUnavailable.length,
                          (index) {
                        return Card(
                          color: detailC.dateUnavailable[index].avail == true
                              ? ConstColors.green20
                              : ConstColors.red40,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                                '${detailC.dateUnavailable[index].date} WIB'),
                          ),
                        );
                      })),
                ]),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FilterChip(
        padding: const EdgeInsets.all(5),
        label:
            const Heading.h5Small('Reservation Now', color: ConstColors.white),
        backgroundColor: ConstColors.customRed,
        shape: const StadiumBorder(side: BorderSide()),
        onSelected: (bool value) {
          transac(context);
        },
      ),
    );
  }

  SizedBox price() {
    return SizedBox(
      width: Get.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Chip(
              label: Heading.h8SuperSmall(
                  'Weekday 07:00-13:00 Rp ${data.price?.weekday7sd13}/Hours',
                  color: ConstColors.customRed),
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(side: BorderSide()),
            ),
            SeparatorWidget.width6(),
            Chip(
              label: Heading.h8SuperSmall(
                  'Weekday 14:00-18:00 Rp ${data.price?.weekday14sd18}/Hours',
                  color: ConstColors.customRed),
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(side: BorderSide()),
            ),
            SeparatorWidget.width6(),
            Chip(
              label: Heading.h8SuperSmall(
                  'Weekday 18:00-23:59 Rp ${data.price?.weekday18sd00}/Hours',
                  color: ConstColors.customRed),
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(side: BorderSide()),
            ),
            SeparatorWidget.width6(),
            Chip(
              label: Heading.h8SuperSmall(
                  'Weekend 07:00-13:00 Rp ${data.price?.weekend7sd13}/Hours',
                  color: ConstColors.customRed),
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(side: BorderSide()),
            ),
            SeparatorWidget.width6(),
            Chip(
              label: Heading.h8SuperSmall(
                  'Weekend 14:00-18:00 Rp ${data.price?.weekend14sd18}/Hours',
                  color: ConstColors.customRed),
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(side: BorderSide()),
            ),
            SeparatorWidget.width6(),
            Chip(
              label: Heading.h8SuperSmall(
                  'Weekend 18:-23:59 Rp ${data.price?.weekend18sd00}/Hours',
                  color: ConstColors.customRed),
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(side: BorderSide()),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> transac(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetWidget.baseSheet(
              withTopIndicator: true,
              child: GetX<DetailPageController>(
                init: DetailPageController(),
                initState: (_) {},
                builder: (a) {
                  return !a.status.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SeparatorWidget.height8(),
                            Heading.h4Default(
                              f.format(a.datePick.value),
                              color: ConstColors.customRed,
                            ),
                            SeparatorWidget.height24(),
                            TimeRange(
                                alwaysUse24HourFormat: true,
                                fromTitle: const Text(
                                  'Time From',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ConstColors.customRed),
                                ),
                                toTitle: const Text(
                                  'Time To',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ConstColors.customRed),
                                ),
                                titlePadding: 20,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: ConstColors.customRed),
                                activeTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                borderColor: ConstColors.customRed20,
                                backgroundColor: Colors.transparent,
                                activeBackgroundColor: ConstColors.customRed,
                                firstTime:
                                    const TimeOfDay(hour: 07, minute: 00),
                                lastTime: const TimeOfDay(hour: 23, minute: 00),
                                timeStep: 60,
                                timeBlock: 60,
                                onRangeCompleted: (range) {
                                  a.rangeStartTime.value = range!.start.hour;
                                  a.timeOrder.value =
                                      range.end.hour - range.start.hour;

                                  a.validatePrice(data.price!);
                                }),
                            SeparatorWidget.height32(),
                            Heading.h5Small(
                              'Lama Waktu: ${a.timeOrder} Jam, Total: Rp ${a.totalOrder}',
                              color: ConstColors.customRed,
                            ),
                            SeparatorWidget.height32(),
                            ButtonWidget.basic(context, "Order Now",
                                backgroundColor: ConstColors.customRed,
                                width: 600,
                                textColor: Colors.white, action: () {
                              a.validateOrder(data);
                            }),
                            SeparatorWidget.height12()
                          ],
                        )
                      : ConfirmPayment(
                          data: Transaction(
                              invoice: a.invoice.value,
                              price: a.totalOrder.value));
                },
              ),
            ));
  }
}
