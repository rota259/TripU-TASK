import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';

// الـ darkModeTileBuilder اللي جاي مع flutter_map بيطلع الشوارع بمبي والنيل أخضر
// فعملت filter بنفسي: grayscale مقلوب مع لمسة أزرق خفيفة، شبه خرايط تطبيقات التوصيل
const _darkMatrix = <double>[
  -0.18, -0.60, -0.06, 0, 228, //
  -0.18, -0.60, -0.06, 0, 232, //
  -0.17, -0.58, -0.06, 0, 244, //
  0, 0, 0, 1, 0,
];

Widget darkTileBuilder(BuildContext context, Widget tile, TileImage image) {
  return ColorFiltered(colorFilter: const ColorFilter.matrix(_darkMatrix), child: tile);
}
