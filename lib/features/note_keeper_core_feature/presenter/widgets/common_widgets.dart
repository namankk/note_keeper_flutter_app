import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class NoResultFoundWidget extends StatelessWidget {
  final String _imagePath;
  final String _titleText;
  final String _descText;

  const NoResultFoundWidget({
    required String imagePath,
    required String titleText,
    String descText = "",
  })  : _imagePath = imagePath,
        _titleText = titleText,
        _descText = descText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(_imagePath),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                _titleText,
                style: GoogleFonts.margarine(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            if (_descText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: Text(
                    _descText,
                    style: GoogleFonts.manrope(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}
