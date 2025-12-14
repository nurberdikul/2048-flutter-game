// lib/tile_component.dart
import 'package:flutter/material.dart';

abstract class TileComponent {
  Widget build(double size);
}

class BaseTile implements TileComponent {
  final int value;
  
  BaseTile(this.value);
  
  @override
  Widget build(double size) {
    final fontSize = _getFontSize(size);
    
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        value == 0 ? '' : '$value',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
  
  double _getFontSize(double size) {
    if (size < 40) return 12;
    if (size < 50) return 14;
    if (size < 60) return 16;
    if (size < 70) return 18;
    if (size < 80) return 20;
    return 22;
  }
}

class ColoredTileDecorator implements TileComponent {
  final int _value;
  
  ColoredTileDecorator(BaseTile tile) : _value = tile.value;
  
  @override
  Widget build(double size) {
    final fontSize = _getFontSize(size);
    final textColor = _getTextColor();
    final borderRadius = size < 50 ? 4.0 : 6.0;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          _value == 0 ? '' : '$_value',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
  
  Color _getColor() {
    switch (_value) {
      case 2: return Color(0xFFEEE4DA);
      case 4: return Color(0xFFEDE0C8);
      case 8: return Color(0xFFF2B179);
      case 16: return Color(0xFFF59563);
      case 32: return Color(0xFFF67C5F);
      case 64: return Color(0xFFF65E3B);
      case 128: return Color(0xFFEDCF72);
      case 256: return Color(0xFFEDCC61);
      case 512: return Color(0xFFEDC850);
      case 1024: return Color(0xFFEDC53F);
      case 2048: return Color(0xFFEDC22E);
      default: return Color(0xFFCDC1B4);
    }
  }
  
  Color _getTextColor() {
    switch (_value) {
      case 2:
      case 4:
        return Color(0xFF776E65);
      case 8:
      case 16:
      case 32:
      case 64:
        return Colors.white;
      case 128:
      case 256:
      case 512:
        return Colors.white;
      case 1024:
      case 2048:
        return Colors.white;
      default:
        return Colors.black;
    }
  }
  
  double _getFontSize(double size) {
    final length = _value.toString().length;
    
    if (size < 40) {
      return length > 3 ? 10 : 12;
    } else if (size < 50) {
      return length > 3 ? 12 : 14;
    } else if (size < 60) {
      return length > 3 ? 14 : 16;
    } else if (size < 70) {
      return length > 3 ? 16 : 18;
    } else if (size < 80) {
      return length > 3 ? 18 : 20;
    } else {
      return length > 3 ? 20 : 22;
    }
  }
}

// Tile Factory (Factory Method pattern)
abstract class TileFactory {
  TileComponent createTile(int value);
}

class DefaultTileFactory implements TileFactory {
  @override
  TileComponent createTile(int value) {
    final base = BaseTile(value);
    return ColoredTileDecorator(base);
  }
}

class MinimalTileFactory implements TileFactory {
  @override
  TileComponent createTile(int value) {
    return BaseTile(value);
  }
}

class RainbowTileFactory implements TileFactory {
  @override
  TileComponent createTile(int value) {
    return _RainbowTile(BaseTile(value));
  }
}

class _RainbowTile implements TileComponent {
  final int _value;
  
  _RainbowTile(BaseTile tile) : _value = tile.value;
  
  @override
  Widget build(double size) {
    final fontSize = _getFontSize(size);
    final hue = (_value * 30) % 360;
    final color = HSLColor.fromAHSL(1.0, hue.toDouble(), 0.7, 0.7).toColor();
    final brightness = color.computeLuminance();
    final textColor = brightness > 0.5 ? Colors.black : Colors.white;
    final borderRadius = size < 50 ? 4.0 : 6.0;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          _value == 0 ? '' : '$_value',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
  
  double _getFontSize(double size) {
    final length = _value.toString().length;
    
    if (size < 40) {
      return length > 3 ? 10 : 12;
    } else if (size < 50) {
      return length > 3 ? 12 : 14;
    } else if (size < 60) {
      return length > 3 ? 14 : 16;
    } else if (size < 70) {
      return length > 3 ? 16 : 18;
    } else if (size < 80) {
      return length > 3 ? 18 : 20;
    } else {
      return length > 3 ? 20 : 22;
    }
  }
}