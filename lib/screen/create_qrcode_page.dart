import 'package:flutter/material.dart';
import 'package:qrcode/generated/l10n.dart';

class CreateQrcodePage extends StatefulWidget {
  const CreateQrcodePage({Key? key}) : super(key: key);

  @override
  State<CreateQrcodePage> createState() => _CreateQrcodePageState();
}

class _CreateQrcodePageState extends State<CreateQrcodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).buildQrcode),
      ),
      body: Container(),
    );
  }
}

class CreateQrcodeTitle extends StatelessWidget {
  const CreateQrcodeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
