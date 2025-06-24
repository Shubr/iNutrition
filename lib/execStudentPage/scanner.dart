import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  late CameraController _controller;
  late BarcodeScanner _barcodeScanner;
  List<CameraDescription> cameras = [];
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    _setupCamerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildWidget());
  }

  Widget _buildWidget() {
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
        child: SizedBox.expand(
      child: Stack(
        children: [
          SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: CameraPreview(cameraController!)),
          Center(child: SvgPicture.asset("assets/icons/crossHair.svg"))
        ],
      ),
    ));
  }

  Future<void> _setupCamerController() async {
    List<CameraDescription> camera = await availableCameras();
    if (camera.isNotEmpty) {
      setState(() {
        cameras = camera;
        cameraController =
            CameraController(camera.first, ResolutionPreset.medium);
      });
    }
    cameraController?.initialize().then((_) {
      setState(() {});
    });
  }
}
