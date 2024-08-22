import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as GF;
import 'package:hydrow/flutter_flow/flutter_flow_animations.dart';
import 'package:flutter_animate/effects/fade_effect.dart';
import 'package:flutter_animate/num_duration_extensions.dart';
final animationsMap = {
  'columnOnPageLoadAnimation': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    effects: [
      FadeEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: 0.0,
        end: 1.0,
      ),
    ],
  ),
};

PreferredSizeWidget genAppBar(String heading, {bool centerTitle = false}) {
  return AppBar(
    backgroundColor: Color(0xFF112025),
    title: Text(
      heading,
      style: GF.GoogleFonts.leagueSpartan(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.normal,
        fontSize: 22,
      ),
    ),
    centerTitle: centerTitle,
  );
}
