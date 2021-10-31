import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pramaan/src/notifiers/kyc.notifier.dart';
import 'package:pramaan/src/notifiers/otp.notifier.dart';
import 'package:pramaan/src/notifiers/pin.notifier.dart';
import 'package:pramaan/src/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:pramaan/src/widgets/custom_button.dart';

class CustomerOtpScreen extends StatefulWidget {
  const CustomerOtpScreen({Key? key}) : super(key: key);

  @override
  _CustomerOtpScreenState createState() => _CustomerOtpScreenState();
}

class _CustomerOtpScreenState extends State<CustomerOtpScreen> {
  TextEditingController? _otpController, _phoneController;
  String? otp;
  String? phone;
  @override
  void initState() {
    _otpController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _otpController?.dispose();
    _phoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        Lottie.asset(
          Assets.otp,
          height: 150,
          repeat: true,
        ),
        'OTP has been sent to your registered mobile number of the resident.'
            .text
            .lg
            .semiBold
            .align(TextAlign.center)
            .makeCentered()
            .px64(),
        // VxBox(
        //   child: TextField(
        //     controller: _phoneController,
        //     decoration: const InputDecoration(
        //       border: OutlineInputBorder(),
        //       labelText: 'Phone number',
        //     ),
        //     inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        //     keyboardType: TextInputType.number,
        //     onChanged: (_) {
        //       phone = _phoneController!.text;
        //     },
        //   ),
        // ).py24.make().px32(),
        VxBox(
          child: TextField(
            controller: _otpController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'OTP',
            ),
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            onChanged: (_) {
              otp = _otpController!.text;
            },
          ),
        ).py24.make().px32(),
        // 'Resend OTP'.text.bold.makeCentered().p32(),
        CustomButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            Function loading = context.showLoading(msg: 'Verfiying OTP');
            Future<void>.delayed(const Duration(milliseconds: 50), loading());
            context.read<Pin>().generatePin();
            loading = context.showLoading(msg: 'Fetching eKYC data.');
            await context.read<KYCModel>().fetchKYC(
                  uid: context.read<OTPModel>().uidNumber,
                  pin: context.read<Pin>().pin,
                  otp: otp,
                  txnNumber: context.read<OTPModel>().txnId,
                );
            if (context.read<KYCModel>().status!.toLowerCase() != 'success') {
              Future<void>.delayed(const Duration(milliseconds: 50), loading());
              VxToast.show(context, msg: 'Failed to load eKYC data.');
            } else {
              Future<void>.delayed(const Duration(milliseconds: 50), loading());
              loading = context.showLoading(msg: 'Loading data.');
              bool dataWritten = await context.read<KYCModel>().writeToFile(
                    context.read<KYCModel>().eKycXML,
                    loading: loading,
                  );
              VxToast.show(
                context,
                msg: dataWritten ? 'Success in fetching eKYC data.' : 'Failed to fetch eKYC data.',
                bgColor: dataWritten ? Colors.green : Colors.red,
              );
              Future<void>.delayed(const Duration(milliseconds: 50), loading());
              await Navigator.of(context).pushReplacementNamed(dataWritten ? '/userData' : '/failedScreen');
            }
            // String? vid = await CustomerPost().generateVID(
            //   otp.toString(),
            //   phone,
            //   otpTxnId: context.read<OTPModel>().txnId,
            //   aadhar: context.read<OTPModel>().uidNumber,
            // );
            // if (vid != null) {
            //   await Navigator.of(context).pushReplacementNamed('/kyc');
            // } else {
            //   VxToast.show(context, msg: 'Failed to generate VID');
            // }
          },
          child: 'Submit OTP'.text.white.fontFamily('LexendDeca').bold.lg.makeCentered(),
          width: 250,
        ),
      ].vStack().centered(),
    );
  }
}
