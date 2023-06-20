import 'package:flutter/material.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/modules/report/controllers/reports_controller.dart';
import 'package:reservation_apps/app/modules/widgets/typography.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.repC,
  });

  final ReportController repC;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 100,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: ConstColors.customRed),
        child: DropdownButtonFormField<String>(
          hint: const BodyText.large('Filter', color: ConstColors.white),
          dropdownColor: ConstColors.customRed,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 22,
            color: ConstColors.white,
          ),
          iconSize: 20,
          elevation: 12,
          menuMaxHeight: 250,
          onChanged: (value) {
            value?.toUpperCase() == '1 YEARS'
                ? repC.doGetTransactionReport(3)
                : value?.toUpperCase() == '1 MONTH'
                    ? repC.doGetTransactionReport(2)
                    : repC.doGetTransactionReport(1);
          },
          style: TextStyleConstants.textStyleTextLarge.copyWith(),
          items: ["1 Week", "1 Month", '1 Years'].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: BodyText.dflt(
                  value,
                  color: ConstColors.white,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.repC,
  });
  final ReportController repC;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.red))),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => ConstColors.customRed, // This is what you need!
          ),
        ),
        onPressed: () {
          repC.doCreateExcel();
        },
        child: const Text("Download"));
  }
}
