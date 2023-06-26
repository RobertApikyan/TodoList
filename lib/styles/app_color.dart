import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NonNullColorSwatch extends ColorSwatch<int> {
  const NonNullColorSwatch(super.primary, super.swatch);

  @override
  Color operator [](int index) => super[index]!;
}

class AppColors {

  static const blue = NonNullColorSwatch(
    _bluePrimary,
    <int, Color>{
      0: Color(0xFFffffff),
      10: Color(0xFFe6eff3),
      20: Color(0xFFccdfe7),
      30: Color(0xFFb3ceda),
      40: Color(0xFF99bece),
      50: Color(0xFF80aec2),
      60: Color(0xFF669eb6),
      70: Color(_bluePrimary),
      80: Color(0xFF337d9d),
      90: Color(0xFF1a6d91),
      100: Color(0xFF005d85),
    },
  );
  static const int _bluePrimary = 0xFF4d8eaa;

  static const black = NonNullColorSwatch(_blackPrimary, <int, Color>{
    0: Color(0xFFffffff),
    10: Color(0xFFe6e6e6),
    20: Color(0xFFcccccc),
    30: Color(0xFFb3b3b3),
    40: Color(0xFF999999),
    50: Color(0xFF808080),
    60: Color(0xFF666666),
    70: Color(0xFF4d4d4d),
    80: Color(0xFF333333),
    90: Color(0xFF1a1a1a),
    100: Color(_blackPrimary),
  });
  static const int _blackPrimary = 0xFF000000;

  static const neutral = NonNullColorSwatch(_neutralPrimary, <int, Color>{
    0: Color(0xFFF4F4F6),
    10: Color(0xFFEEEEF2),
    20: Color(0xFFDDDDE4),
    30: Color(0xFFD2D1DB),
    40: Color(0xFFC7C6D2),
    50: Color(_neutralPrimary),
    60: Color(0xFF8C8B97),
    70: Color(0xFF5F5E6B),
    80: Color(0xFF51505C),
    90: Color(0xFF42414E),
    100: Color(0xFF33323F),
  });
  static const int _neutralPrimary = 0xFFA9A8B5;


}
