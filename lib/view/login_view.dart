import 'package:fab_lab/pages/qr_page.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const QRPage())),
          child: const Text('dfsd'),
        ),
      ),
    );
  }
}