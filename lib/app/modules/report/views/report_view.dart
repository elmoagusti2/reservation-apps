import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservation_apps/app/modules/report/controllers/reports_controller.dart';
import 'package:reservation_apps/app/modules/report/views/widget/report_button.dart';
import 'package:reservation_apps/app/modules/report/views/widget/report_card.dart';
import 'package:reservation_apps/app/modules/widgets/separator_widget.dart';

class ReportPage extends GetView<ReportController> {
  ReportPage({super.key});

  final repC = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SeparatorWidget.height4(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DownloadButton(repC: repC),
                  ),
                  SeparatorWidget.width6(),
                  FilterButton(repC: repC),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: repC.listTransaction.length,
                itemBuilder: (context, index) => ReportCard(
                  transaction: repC.listTransaction[index],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

