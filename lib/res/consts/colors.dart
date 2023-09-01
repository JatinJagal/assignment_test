import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color splashColor1 = HexColor("#3e52d7");
Color splashColor2 = HexColor("#7b1eb1");
Color testColor = HexColor("#1eb147");
Color whiteColor = HexColor("#ffffff");
Color blackColor = HexColor("#000000");
Color redColor = HexColor("#e30613");
Color blueButton = HexColor('#0B86EA');
Color greenColor = HexColor('#679f87');