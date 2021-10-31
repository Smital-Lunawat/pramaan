import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pramaan/src/notifiers/catcha.notifier.dart';
import 'package:pramaan/src/notifiers/db.notifier.dart';
import 'package:pramaan/src/notifiers/otp.notifier.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:pramaan/src/widgets/custom_button.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({Key? key}) : super(key: key);

  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  String? captcha;
  String? rationNum;
  TextEditingController? _captchaController, _rationController;
  Base64Decoder base64 = const Base64Decoder();

  @override
  void initState() {
    _captchaController = TextEditingController();
    _rationController = TextEditingController();
    context.read<CaptchaModel>().captchaGenerator();
    super.initState();
  }

  @override
  void dispose() {
    _captchaController?.dispose();
    _rationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: <Widget>[
          VxBox(
            child: TextField(
              controller: _rationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ration card Number',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              keyboardType: TextInputType.number,
              onChanged: (_) {
                rationNum = _rationController!.text;
              },
            ),
          ).p32.make(),
          Consumer<CaptchaModel>(builder: (BuildContext context, CaptchaModel captchaModel, Widget? child) {
            return captchaModel.captcha == null
                ? const CircularProgressIndicator(
                    strokeWidth: 3,
                  )
                : Image.memory(
                    base64.convert(
                      captchaModel.captcha!,
                    ),
                  );
          }),
          VxBox(
            child: TextField(
              controller: _captchaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Captcha',
              ),
              onChanged: (_) {
                captcha = _captchaController!.text;
              },
            ),
          ).p32.make(),
          CustomButton(
            onPressed: () async {
              // const MethodChannel platform = MethodChannel('openAUA');
              // try {
              //   await platform.invokeMethod('openAUA');
              //   // print(result);
              // } on Exception catch (e) {
              //   log(e.toString());
              // }
              if (rationNum == null) {
                VxToast.show(context, msg: 'Looks like ration Number is empty.');

                return;
              }
              Function loading = context.showLoading(msg: 'Fetching resident details.');
              FocusScope.of(context).hasFocus ? FocusScope.of(context).unfocus() : null;
              await context.read<Database>().getData(rationNum!);
              Map<String, dynamic>? userData = context.read<Database>().userData;
              String? aadhaar = context.read<Database>().aadharNum;
              if (userData == null) {
                Future<void>.delayed(const Duration(milliseconds: 50), loading());
                VxToast.show(context, msg: 'Looks like the Ration number is wrong.');
              }
              if (captcha != null) {
                await context.read<OTPModel>().otpGenerator(
                      captcha!,
                      context.read<CaptchaModel>().captchaTxnId,
                      aadhar: aadhaar,
                    );
                if (userData != null && context.read<OTPModel>().status!.toLowerCase() != 'success') {
                  setState(() {
                    _captchaController?.clear();
                  });
                  Future<void>.delayed(const Duration(milliseconds: 50), loading());
                  VxToast.show(
                    context,
                    msg: 'Captcha verification failed',
                    bgColor: context.read<OTPModel>().status!.toLowerCase() == 'success' ? Colors.green : Colors.red,
                  );
                  await Provider.of<CaptchaModel>(context, listen: false).captchaGenerator();
                } else {
                  Future<void>.delayed(const Duration(milliseconds: 50), loading());
                  await Navigator.pushReplacementNamed(context, '/otp');
                }
              } else {
                Future<void>.delayed(const Duration(milliseconds: 50), loading());
                VxToast.show(context, msg: 'Captcha is empty');
              }
            },
            child: 'Submit'.text.white.fontFamily('LexendDeca').bold.lg.makeCentered(),
            width: 200,
          ),
        ].vStack(
          alignment: MainAxisAlignment.center,
          crossAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
