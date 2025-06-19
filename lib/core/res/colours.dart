import 'dart:ui';

class Colours {
  const Colours._();

  // Gradients

  static const List<Color> hoverGradientColor = [
    Color(0xFFF43F5E),
    Color(0x33FFFFFF),
  ];
  static const List<Color> activeGradientColor = [
    Color(0xFFF43F5E),
    Color(0x33000000),
  ];
  static const List<Color> redGradientColor = [
    Color(0xFFFF1843),
    Color(0xFFFF7E95),
  ];
  static const List<Color> yellowGradientColor = [
    Color(0xFFFFB800),
    Color(0xFFFFDA7B),
  ];

  // Primary
  static const Color primaryColor = Color(0xFFF43F5E);
  static const Color primary90Color = Color(0xE6F43F5E);
  static const Color primary80Color = Color(0xCCF43F5E);
  static const Color primary70Color = Color(0xB3F43F5E);
  static const Color primary60Color = Color(0x99F43F5E);
  static const Color primary50Color = Color(0x80F43F5E);
  static const Color primary40Color = Color(0x66F43F5E);
  static const Color primary30Color = Color(0x4DF43F5E);
  static const Color primary20Color = Color(0x33F43F5E);
  static const Color primary10Color = Color(0x1AF43F5E);

  // Secondary
  static const Color secondaryColor = Color(0xFFFFB800);
  static const Color secondary90Color = Color(0xE6FFB800);
  static const Color secondary80Color = Color(0xCCFFB800);
  static const Color secondary70Color = Color(0xB3FFB800);
  static const Color secondary60Color = Color(0x99FFB800);
  static const Color secondary50Color = Color(0x80FFB800);
  static const Color secondary40Color = Color(0x66FFB800);
  static const Color secondary30Color = Color(0x4DFFB800);
  static const Color secondary20Color = Color(0x33FFB800);
  static const Color secondary10Color = Color(0x1AFFB800);

  // Tertiary1
  static const Color tertiary1Color = Color(0xFF1867FF);
  static const Color tertiary190Color = Color(0xE61867FF);
  static const Color tertiary180Color = Color(0xCC1867FF);
  static const Color tertiary170Color = Color(0xB31867FF);
  static const Color tertiary160Color = Color(0x991867FF);
  static const Color tertiary150Color = Color(0x801867FF);
  static const Color tertiary140Color = Color(0x661867FF);
  static const Color tertiary130Color = Color(0x4D1867FF);
  static const Color tertiary120Color = Color(0x331867FF);
  static const Color tertiary110Color = Color(0x1A1867FF);

  // Tertiary2
  static const Color tertiary2Color = Color(0xFFFF1843);
  static const Color tertiary290Color = Color(0xE6FF1843);
  static const Color tertiary280Color = Color(0xCCFF1843);
  static const Color tertiary270Color = Color(0xB3FF1843);
  static const Color tertiary260Color = Color(0x99FF1843);
  static const Color tertiary250Color = Color(0x80FF1843);
  static const Color tertiary240Color = Color(0x66FF1843);
  static const Color tertiary230Color = Color(0x4DFF1843);
  static const Color tertiary220Color = Color(0x33FF1843);
  static const Color tertiary210Color = Color(0x1AFF1843);

  // Neutral
  static const Color blackColour = Color(0xFF09101D);
  static const Color whiteColour = Color(0xFFFFFFFF);
  static const Color neutral1Colour = Color(0xFF2C3A4B);
  static const Color neutral2Colour = Color(0xFF394452);
  static const Color neutral3Colour = Color(0xFF545D69);
  static const Color neutral4Colour = Color(0xFF6D7580);
  static const Color neutral5Colour = Color(0xFF858C94);
  static const Color neutral6Colour = Color(0xFFA5ABB3);
  static const Color neutral7Colour = Color(0xFFDADEE3);
  static const Color neutral8Colour = Color(0xFFEBEEF2);
  static const Color neutral9Colour = Color(0xFFF4F6F9);

  // Accent
  static const Color accent1Colour = Color(0xFFECB2F2);
  static const Color accent11Colour = Color(0x47ECB2F2);
  static const Color accent2Colour = Color(0xFF2D6A6A);
  static const Color accent22Colour = Color(0x1A2D6A6A);
  static const Color accent3Colour = Color(0xFFE9AD8C);
  static const Color accent33Colour = Color(0x3BE9AD8C);
  static const Color accent4Colour = Color(0xFF221874);
  static const Color accent44Colour = Color(0x1A221874);
  static const Color accent5Colour = Color(0xFF7CC6D6);
  static const Color accent55Colour = Color(0x407CC6D6);
  static const Color accent6Colour = Color(0xFFE1604D);
  static const Color accent66Colour = Color(0x26E1604D);

  // Action Primary
  static const Color defaultColor = Color(0xFFF43F5E);
  static const Color disabledColor = Color(0x80f43f5e);
  static const Color hover10Color = Color(0x1AF43F5E);
  static const Color active20Color = Color(0x33F43F5E);
  static const Color invertedColor = Color(0xFFFFFFFF);

  // Action Secondary
  static const Color defaultSecondaryColor = Color(0xFFFFB800);
  static const Color hoverSecondaryColor = Color(0xFFFFB800);
  static const Color activeSecondaryColor = Color(0xFFFFB800);
  static const Color disabledSecondaryColor = Color(0x80FFB800);
  static const Color hover10SecondaryColor = Color(0x1AFFB800);
  static const Color active20SecondaryColor = Color(0x33FFB800);
  static const Color invertedSecondaryColor = Color(0xFFFFFFFF);

  // Action Neutral
  static const Color defaultActionColor = Color(0xFF9098A1);
  static const Color hoverActionColor = Color(0xFF858C94);
  static const Color activeActionColor = Color(0xFF798087);
  static const Color disabledActionColor = Color(0xB39098A1);
  static const Color hover10ActionColor = Color(0x1A6D7580);
  static const Color active20ActionColor = Color(0x336D7580);
  static const Color invertedActionColor = Color(0xFFFFFFFF);

  //   States
  static const Color successColor = Color(0xFF23A757);
  static const Color warningColor = Color(0xFFB95000);
  static const Color errorColor = Color(0xFFDA1414);
  static const Color infoColor = Color(0xFF2E5AAC);
  static const Color successBgColor = Color(0xFFEDF9F0);
  static const Color warningBgColor = Color(0xFFFFF4EC);
  static const Color errorBgColor = Color(0xFFFEEFEF);
  static const Color infoBgColor = Color(0xFFEEF2FA);

  //   Other
  static const Color dark1Color = Color(0xFF161B20);
  static const Color dark2Color = Color(0xFF0D0D0D);
  static const Color dark3Color = Color(0xFF141414);
  static const Color dark4Color = Color(0xFF252525);

  //   Smoother
  static const Color smoother1Color = Color(0xFFFFFBFB);
  static const Color smoother2Color = Color(0xFFF6F9FF);
  static const Color smoother3Color = Color(0xFFF6F8FB);
}
