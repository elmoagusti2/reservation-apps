import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/models/transaction.dart';
import 'package:reservation_apps/app/modules/widgets/container_widget.dart';
import 'package:reservation_apps/app/modules/widgets/typography.dart';

class ReportCard extends StatelessWidget {
  final Transaction transaction;
  const ReportCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ContainerWidget.rounded(
        borderColor: ConstColors.customRed,
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading.h5Small(
                  'name: ${transaction.email}',
                  color: ConstColors.customRed,
                ),
                Heading.capDefault('Invoice Number: ${transaction.invoice}'),
                Heading.capDefault('Total: Rp ${transaction.price}'),
                Heading.capDefault(
                  'Status: ${transaction.status}',
                  color: transaction.status!
                      ? ConstColors.green30
                      : ConstColors.red30,
                ),
              ],
            ),
          ],
        ),
        width: Get.width,
        height: 120,
        backgroundColor: ConstColors.gray20,
      ),
    );
  }
}
