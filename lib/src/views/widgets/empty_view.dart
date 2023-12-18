import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notesbucket/src/res/assets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
        ),
        Lottie.asset(AnimationsAssets.empty),
        Text(
          "Things look empty here. Tap + to start",
          style: GoogleFonts.poppins(fontSize: 18),
        )
      ],
    );
  }
}
