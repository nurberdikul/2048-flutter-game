// lib/tile_factory.dart

import 'dart:math';

/// Абстрактный Создатель (TileFactory).
abstract class TileFactory {
  int createNewTile();
}

/// Конкретный Создатель: Создает плитки 2 или 4.
class TwoOrFourTileFactory implements TileFactory {
  @override
  int createNewTile() {
    // 10% шанс на 4, 90% шанс на 2.
    int r = Random().nextInt(10); 
    return (r == 0) ? 4 : 2; 
  }
}