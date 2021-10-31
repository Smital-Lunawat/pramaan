import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pramaan/src/notifiers/kyc.notifier.dart';
import 'package:pramaan/src/notifiers/pin.notifier.dart';
import 'package:pramaan/src/utils/app_theme.dart';
import 'package:pramaan/src/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  bool failed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        Consumer<KYCModel>(
          builder: (BuildContext context, KYCModel kycModel, Widget? child) {
            return kycModel.status == null
                ? const CircularProgressIndicator().centered()
                : 'eKYC data has been fetched and writing to the storage'
                    .text
                    .semiBold
                    .base
                    .align(TextAlign.center)
                    .makeCentered()
                    .px32()
                    .py64();
          },
        ),
        VxBox(
          child: <Widget>[
            const Icon(
              Icons.file_upload_rounded,
              size: 30,
              color: AppColors.appMainColor,
            ),
            'Pick the user data'
                .text
                .color(
                  AppColors.appMainColor.withOpacity(
                    0.6,
                  ),
                )
                .base
                .makeCentered(),
          ].vStack(alignment: MainAxisAlignment.spaceEvenly).centered(),
        )
            .withDecoration(
              BoxDecoration(
                color: AppColors.appMainColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.appMainColor.withOpacity(0.3),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
            )
            .height(100)
            .make()
            .px64()
            .centered()
            .onTap(() async {
          File? pickedFile;
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: <String>['zip'],
          );
          if (result != null) {
            pickedFile = File(result.files.single.path!);
          }
          Function loading = context.showLoading(msg: 'Reading data...');
          String? pin = context.read<Pin>().pin;
          String path = (await getExternalStorageDirectory())!.path;
          try {
            log('Pin we get ' + pin!);
            try {
              if (!await pickedFile!.exists()) {
                await Future<void>.delayed(const Duration(milliseconds: 50), loading());
                return VxToast.show(context, msg: 'No file found');
              }
              Uint8List bytes = await pickedFile.readAsBytes();
              // Decode the Zip file
              Archive archive = ZipDecoder().decodeBytes(bytes, password: pin);
              // Extract the contents of the Zip archive to disk.
              // Extract the zip file conetent and print the path of the file.
              for (ArchiveFile file in archive) {
                String filePath = path + '/kyc.xml';
                if (file.isFile) {
                  List<int> data = file.content as List<int>;
                  File(filePath)
                    ..createSync(recursive: true)
                    ..writeAsBytesSync(data);
                }
              }
              if (File(path + '/kyc.xml').existsSync()) {
                print('File exists');
                String file64 = base64Encode(await File(path + '/kyc.xml').readAsBytes());
                print(file64);
                String xml = await File(path + '/kyc.xml').readAsString();
                print(xml);
              }
            } on Exception catch (_) {
              await Future<void>.delayed(const Duration(milliseconds: 50), loading());

              setState(() {
                failed = true;
              });
              VxToast.show(context,
                  msg:
                      'Error occured while extracting data. So please extract it your self and click on the verify button.');
            }
          } on PlatformException catch (_) {
            await Future<void>.delayed(const Duration(milliseconds: 50), loading());
            setState(() {
              failed = true;
            });
            VxToast.show(context,
                msg:
                    'Error occured while extracting data. So please extract it your self and click on the verify button.');
          } on FormatException catch (_) {
            await Future<void>.delayed(const Duration(milliseconds: 50), loading());
            setState(() {
              failed = true;
            });
            VxToast.show(context,
                msg:
                    'Error occured while extracting data. So please extract it your self and click on the verify button.');
          } on Exception catch (_) {
            await Future<void>.delayed(const Duration(milliseconds: 50), loading());
            setState(() {
              failed = true;
            });
            VxToast.show(context,
                msg:
                    'Error occured while extracting data. So please extract it your self and click on the verify button.');
          }
        }),
        failed
            ? CustomButton(
                    onPressed: () async {
                      const MethodChannel platform = MethodChannel('com.pramaan');
                      try {
                        await platform.invokeMethod('openAUA');
                      } on Exception catch (e) {
                        VxToast.show(context, msg: e.toString());
                      }
                    },
                    width: 200,
                    child: 'Verify'.text.white.fontFamily('LexendDeca').bold.lg.makeCentered())
                .py16()
            : const SizedBox.shrink(),
      ].vStack(alignment: MainAxisAlignment.center).centered(),
      // body: QrImage(data: ).centered().p64().cornerRadius(10),
    );
  }

  Future<void> unzip(String filePath, String baseName) async {
    List<int> bytes = File('$filePath/$baseName').readAsBytesSync();
    // Decode the Zip file
    Archive archive = ZipDecoder().decodeBytes(bytes, verify: true, password: '1qaz2wsx');
    for (ArchiveFile file in archive) {
      print('file:' + file.name);
      print('size:' + (file.size / 1024).ceil().toString() + 'K');
      print(file.content.toString());
      if (file.isFile) {
        File outFile = File('$filePath/out/${file.name}');
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      } else {
        await Directory('$filePath/out/${file.name}').create(recursive: true);
      }
    }
  }
}
