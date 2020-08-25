import 'package:flutter/material.dart';

class Device extends StatelessWidget {
  const Device();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: AddMedicalDevice(),
    ));
  }
}

class AddMedicalDevice extends StatefulWidget {
  AddMedicalDevice();
  @override
  _AddMedicalDeviceState createState() => _AddMedicalDeviceState();
}

class _AddMedicalDeviceState extends State<AddMedicalDevice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(child: Text("Sync Medical Device")),
    );
  }
}
