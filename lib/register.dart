import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/backicon.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
        title: const Text(
          "iNutrition",
          style: TextStyle(fontFamily: "Carter"),
        ),
      ),
    );
  }
}
