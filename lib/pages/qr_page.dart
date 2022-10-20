import 'dart:developer';
import 'dart:io';

import 'package:fab_lab/bloc/login%20cubit/login_cubit.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../constants/custom_colors.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key, required this.cont}) : super(key: key);
  final cont;

  @override
  State<StatefulWidget> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scaner'),
        backgroundColor: CustomColors.background,
      ),
      body: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            _buildQrView(context),
            Positioned(
              bottom: 40,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    'Наведите на QR Code',
                    style: white16W600,
                    textAlign: TextAlign.center,
                  )),
            ),
            // if (result != null)
            //     Text(
            //         'Data: ${result!.code}')
            //   else
            //     const Text('Scan a code'),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 16,
          borderLength: 60,
          borderWidth: 6,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    int count = 0;
    setState(() {
      this.controller = controller;
      controller.resumeCamera();
    });
    controller.scannedDataStream.listen((scanData) {
      if (count == 0) {
        setState(() {
          count++;
        });
        Navigator.of(context).pop();
        BlocProvider.of<LoginCubit>(context)
            .checkToken(scanData.code.toString(), widget.cont);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Нет доступа к камере')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
