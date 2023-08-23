import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AqrisoPage extends StatefulWidget {
  int id;
  String name;
  // String pages;
  String aqris;
  AqrisoPage(this.id, this.name, this.aqris);

  @override
  State<AqrisoPage> createState() => _AqrisoPageState();
}

class _AqrisoPageState extends State<AqrisoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            centerTitle: true,
            title: Text(widget.name),
          ),
          body: SfPdfViewer.network(widget.aqris),
        ),
      ),
    );
  }
}
