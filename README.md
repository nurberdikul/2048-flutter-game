<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/8b3bab1e-4b9f-477e-b1b3-bf9141e0a02e" /><img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/fb871ac9-0f78-450d-892d-6255c7d5c8f1" /># 🎮 2048 Game - Flutter Implementation

![Flutter](https://img.shields.io/badge/Flutter-3.19-blue)
![Dart](https://img.shields.io/badge/Dart-3.0-blue)
![Design Patterns](https://img.shields.io/badge/Design%20Patterns-3-green)
![SOLID](https://img.shields.io/badge/SOLID-5%20principles-green)
 
✅ **Полностью функциональное приложение с нуля**  
✅ **3 паттерна из разных категорий**  
✅ **Соблюдение SOLID принципов**  

## 🏗️ Архитектура и паттерны

### 1. **Factory Method Pattern** (Creational)
- `GameFactory` → `StandardGameFactory`, `ChallengeGameFactory`
- `TileFactory` → `DefaultTileFactory`, `MinimalTileFactory`, `RainbowTileFactory`

### 2. **Decorator Pattern** (Structural)
- `TileComponent` ← `BaseTile` ← `ColoredTileDecorator` ← `RainbowTile`
- Динамическое изменение внешнего вида плиток

### 3. **Command Pattern** (Behavioral)
- `GameCommand` ← `MoveCommand`
- `CommandManager` для управления историей и отменой ходов

## 📐 SOLID Principles

| Принцип | Реализация |
|---------|------------|
| **Single Responsibility** | Каждый класс имеет одну ответственность |
| **Open/Closed** | Код открыт для расширения, закрыт для модификации |
| **Liskov Substitution** | Подклассы заменяют родительские классы |
| **Interface Segregation** | Маленькие, специфичные интерфейсы |
| **Dependency Inversion** | Зависимости от абстракций, а не реализаций |

## 🎮 Функциональность

- Полная игра 2048 с логикой слияния плиток
- Система отмены ходов (Command Pattern)
- 3 визуальные темы (Decorator Pattern)
- 2 режима игры (Factory Method Pattern)
- Адаптивный UI для разных размеров экрана
- Управление свайпами и кнопками

lib/
├── command/                   # Паттерн Command
│   ├── command_interface.dart
│   ├── command_manager.dart
│   └── move_command.dart
├── game_engine.dart           # Логика игры
├── game_factory.dart          # Паттерн Factory Method
├── home.dart                  # Игровой экран
├── main.dart                  # Точка входа
├── main_menu.dart             # Главное меню
├── score_manager.dart         # Управление очками
└── tile_component.dart        # Паттерн Decorator

<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/c6fc598b-3687-48ac-a70a-259eb108d98c" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/93148032-b7f5-44df-bc5a-8e6d32ec1ce3" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/78c4b1db-18b9-4544-ae93-8f58cbfd02e6" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/191d3f0c-819c-4715-bc5a-62b94d613ca9" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/05edf2b7-e71b-4ebd-abfa-37070e856180" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/6da2edd7-721b-4cf8-86e8-d5a44f812a05" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/b823a6cd-7652-4557-ab4f-e3be9be297d2" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/b3533c38-c03c-4dea-aac9-7fb60b5d2f73" />









Nurdaulet - Архитектура, паттерны проектирования
Dilyara - UI/UX, игровая логика
Khanbibi - Тестирование, документация
