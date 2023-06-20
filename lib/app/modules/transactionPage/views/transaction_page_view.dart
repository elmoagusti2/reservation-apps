// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:reservation_apps/app/common/constants/colors.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';
import 'package:reservation_apps/app/models/transaction.dart' as t;
import 'package:reservation_apps/app/modules/widgets/bottom_sheet_widget.dart';
import 'package:reservation_apps/app/modules/widgets/button_widget.dart';
import 'package:reservation_apps/app/modules/widgets/container_widget.dart';
import 'package:reservation_apps/app/modules/widgets/separator_widget.dart';
import 'package:reservation_apps/app/modules/widgets/typography.dart';

import '../controllers/transaction_page_controller.dart';

class TransactionPageView extends GetView<TransactionPageController> {
  final trxC = Get.put(TransactionPageController());
  final authC = Get.find<AuthController>();

  TransactionPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: trxC.transacStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: ConstColors.red20),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Heading.h6XSmall('Belum ada data', color: ConstColors.red20),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            t.Transaction data =
                t.Transaction.fromMap(document.data() as Map<String, dynamic>)
                    .copyWith(id: document.id);
            final dp = data.price! * 30 / 100;
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
                          data.fieldName ?? '',
                          color: ConstColors.customRed,
                        ),
                        Heading.capDefault('Invoice Number: ${data.invoice}'),
                        Heading.capDefault('Total: Rp ${data.price}'),
                        Heading.capDefault(
                          '${'${data.date}  ${data.time}:00'} - ${int.parse(data.time!) + data.duration!}:00 WIB',
                        ),
                        data.status == false
                            ? const Heading.capDefault(
                                'Status: Belum Dibayar',
                                color: ConstColors.red50,
                              )
                            : Heading.capDefault(
                                'Status: Sudah Dibayar Rp ${dp.toInt()}',
                                color: ConstColors.green20,
                              ),
                      ],
                    ),
                    if (authC.admin.value)
                      Align(
                        alignment: Alignment.centerRight,
                        // child: Image.asset('assets/icons/whatsapp.png',height: 30,)
                        child: InkWell(
                          child: ContainerWidget.rounded(
                              width: 60,
                              height: 30,
                              const Center(
                                  child: Heading.capDefault(
                                'PAID',
                                color: Colors.white,
                              )),
                              backgroundColor: ConstColors.customRed,
                              padding: const EdgeInsets.all(0)),
                          onTap: () {
                            trxC.updateStats(data);
                          },
                        ),
                      ),
                    Align(
                        alignment: Alignment.bottomRight,
                        // child: Image.asset('assets/icons/whatsapp.png',height: 30,)
                        child: InkWell(
                          child: ContainerWidget.rounded(
                              width: 90,
                              height: 30,
                              const Center(
                                  child: Heading.capDefault(
                                'CONFIRM',
                                color: Colors.white,
                              )),
                              backgroundColor: ConstColors.customRed,
                              padding: const EdgeInsets.all(0)),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    BottomSheetWidget.baseSheet(
                                        child: ConfirmPayment(data: data),
                                        withTopIndicator: true));
                          },
                        ))
                  ],
                ),
                width: Get.width,
                height: 140,
                backgroundColor: ConstColors.gray20,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class ConfirmPayment extends StatelessWidget {
  final t.Transaction data;
  const ConfirmPayment({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dp = data.price! * 30 / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SeparatorWidget.height8(),
        const Heading.h5Small(
          "Please Transfer to:",
          color: ConstColors.customRed,
        ),
        SeparatorWidget.height16(),
        Row(
          children: [
            const Heading.h7XXSmall(
              'BCA',
              color: ConstColors.blue40,
            ),
            SeparatorWidget.width10(),
            const Heading.h7XXSmall('A/N: Juriyah 3450389527'),
            GestureDetector(
              child: const Icon(Icons.copy),
              onTap: () async {
                await Clipboard.setData(
                    const ClipboardData(text: "3450389527"));
              },
            ),
          ],
        ),
        SeparatorWidget.height24(),
        const Heading.h7XXSmall(
            'Jika sudah melakukan transfer pembayaran, bisa lakukan konfirmasi pesanan.'),
        SeparatorWidget.height32(),
        ButtonWidget.basic(context, "Confirm Payment",
            backgroundColor: ConstColors.customRed,
            width: 600,
            textColor: Colors.white, action: () async {
          await launchUrlString(
              'https://api.whatsapp.com/send/?phone=628978522848&text=Saya%20sudah%20membayar%20biaya%20booking%20Dp%20lapangan%20sebesar%20Rp$dp%20dengan%20nomor%20invoice:${data.invoice}.%20berikut%20bukti%20transfer:',
              mode: LaunchMode.externalNonBrowserApplication);
        }),
        SeparatorWidget.height12()
      ],
    );
  }
}
