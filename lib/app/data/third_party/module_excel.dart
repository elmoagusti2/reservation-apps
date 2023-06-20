import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reservation_apps/app/models/transaction.dart';

class ExcelModule {
  Future<bool> doCreateExcel(
      List<Transaction> listTransaction, String time) async {
    try {
      var excel = Excel.createExcel();
      int total = 0;
      var dataColumn = [
        'No',
        'Invoice Number',
        'email',
        'Field',
        'duration',
        'time',
        'price',
        'status'
      ];
      for (var table in excel.tables.keys) {
        CellStyle cellStyleMain = CellStyle(
          bold: true,
          textWrapping: TextWrapping.WrapText,
          fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
          rotation: 0,
          backgroundColorHex: '#d7ae4c',
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
        );

        var sheet = excel['Sheet1'];
        //create data from DB
        for (var i = 0; i < listTransaction.length; i++) {
          var data = listTransaction[i];
          var cell1 = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 4));
          var cell2 = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 4));
          cell1.value = i + 1;
          var cell3 = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 4));
          var cell4 = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 4));
          var cell5 = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 4));
          var cell6 = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 4));
          var cell7 = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 4));
          var cell8 = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 4));
          cell1.value = i + 1;
          cell2.value = data.invoice;
          cell3.value = data.email;
          cell4.value = data.fieldName;
          cell5.value = '${data.duration} Hours';
          cell6.value = '${data.date} ${data.time}:00';
          cell7.value = data.price;
          cell8.value = data.status! ? 'TRUE' : 'FALSE';
          total += data.status! ? data.price! : 0;
        }
        //create data static
        for (var i = 0; i < dataColumn.length; i++) {
          var cell1 = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: i + 2, rowIndex: 3));
          cell1.value = dataColumn[i];
          cell1.cellStyle = cellStyleMain;
        }
        var cellTitle = sheet.cell(CellIndex.indexByString('F2'));
        cellTitle.value = 'REPORTS $time';
        cellTitle.cellStyle = cellStyleMain.copyWith(
          fontColorHexVal: '#7EB829',
        );
        var cellTotal = sheet.cell(CellIndex.indexByColumnRow(
            columnIndex: excel.tables[table]!.maxCols,
            rowIndex: excel.tables[table]!.maxRows));
        cellTotal.value = 'TOTAL: $total';
        cellTotal.cellStyle =
            cellStyleMain.copyWith(backgroundColorHexVal: '#7EB829');
      }
      excel.rename('Sheet1', 'report');

      //create excel
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final androidInfo = await deviceInfoPlugin.androidInfo;
      var status = androidInfo.version.sdkInt >= 33
          ? await Permission.manageExternalStorage.request()
          : await Permission.storage.request();
      if (status.isGranted) {
        var fileBytes = excel.save();
        var directory = Platform.isIOS
            ? await getDownloadsDirectory()
            : Directory('/storage/emulated/0/Download');
        File('${directory!.path}/report $time.xlsx')
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes!);
        Get.snackbar('Success Download',
            'Check Folder: ${directory.path}/report $time.xlsx',
            backgroundColor: const Color.fromARGB(255, 174, 255, 117),
            icon: const Icon(Icons.file_download));
      }
      return true;
    } catch (e) {
      Get.snackbar('Error Download', 'Error, Please check Permission',
          backgroundColor: const Color.fromARGB(255, 255, 117, 117),
          icon: const Icon(Icons.file_download));
      return false;
    }
  }
}
