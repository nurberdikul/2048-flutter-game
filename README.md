
![Flutter](https://img.shields.io/badge/Flutter-3.19-blue)
![Dart](https://img.shields.io/badge/Dart-3.0-blue)
![Design Patterns](https://img.shields.io/badge/Design%20Patterns-3-green)
![SOLID](https://img.shields.io/badge/SOLID-5%20principles-green)
 
📱 2048 Flutter: Software Design Specification
1. Introduction
2048 Flutter is a cross-platform mobile application representing an advanced version of the classic 2048 puzzle game. The project is built using the Dart language and the Flutter framework.
The key feature of this project is the implementation of a Clean Architecture based on classic GoF (Gang of Four) Design Patterns. This approach ensures code modularity, high testability, and the ability to easily scale functionality (adding new modes, themes, and mechanics).
Key Features:
Multi-Mode Support: Standard Mode and "Challenge Mode" (with higher difficulty).
Adaptive Grid: Selectable grid sizes from 3x3 to 6x6.
Undo System: Implementation of move cancellation using a Command stack.
Dynamic Theming: Change visual themes (Classic, Minimal, Rainbow) at runtime.
Progress Persistence: Global high score management.

2. Design Patterns
The project implements four key architectural patterns to solve specific design problems. Below is a detailed description of each, accompanied by source code examples.
2.1. Factory Method
Where it is used:
It is used to create instances of the game engine (GameEngine) and the history manager (CommandManager) depending on the selected game mode.
Problem it Solves:
Decouples the UI (HomePage) from the specific logic of initializing different game modes. It allows adding new modes (e.g., "Time Attack") without modifying the interface code.
Code Example:
<img width="490" height="580" alt="image" src="https://github.com/user-attachments/assets/0f1e9d7b-0adf-4732-bb14-17e9058097b5" />



2.2. Command
Where it is used:
This pattern is the core of the move management system. It encapsulates every player action (swipe) into a separate object, enabling the Undo functionality.
Problem it Solves:
Eliminates the need for a massive controller class that handles game state. It encapsulates the request as an object, allowing for parameterization of clients with different requests, queueing, and supporting undoable operations.
Code Example:
<img width="362" height="750" alt="image" src="https://github.com/user-attachments/assets/477c9cb5-62ee-42b7-8b9e-9e6926640002" />



2.3. Decorator
Where it is used:
Used to dynamically alter the visual appearance of tiles (skins/themes) without changing their internal structure or duplicating rendering logic.
Problem it Solves:
Allows adding new visual behaviors (colors, fonts, styles) to objects individually and dynamically, adhering to the Open/Closed Principle.
Code Example:
<img width="396" height="814" alt="image" src="https://github.com/user-attachments/assets/db4ad275-6d3f-4ae9-8e9e-e646e3304b6d" />



2.4. Singleton
Where it is used:
Used for the ScoreManager to manage global high scores.
Problem it Solves:
Ensures a class has only one instance and provides a global point of access to it. This prevents data inconsistency where different screens might show different high scores.
Code Example:
<img width="421" height="484" alt="image" src="https://github.com/user-attachments/assets/ba0c3035-a941-4fcb-8862-069cc63a7021" />



3. Application of SOLID Principles
The project architecture strictly adheres to SOLID principles, ensuring the system remains maintainable and extensible.
3.1. Single Responsibility Principle (SRP)
A class should have one, and only one, reason to change.
Implementation: We separated game logic, rendering, and history management.
GameEngine: Handles ONLY matrix mathematics.
TileComponent: Handles ONLY visual rendering.
CommandManager: Handles ONLY the history stack.
Benefit: Changing the tile design (View) will never break the game rules (Model).
3.2. Open/Closed Principle (OCP)
Software entities should be open for extension, but closed for modification.
Implementation: The theming system uses the Decorator pattern. To add a "Neon" theme, we simply create a new NeonTileDecorator class.
Benefit: We extend functionality without opening or modifying the stable BaseTile code, reducing the risk of bugs.
3.3. Liskov Substitution Principle (LSP)
Subtypes must be substitutable for their base types.
Implementation: The HomePage accepts the abstract GameFactory interface. It functions correctly regardless of whether StandardGameFactory or ChallengeGameFactory is passed.
Benefit: The UI is decoupled from specific game modes.
3.4. Interface Segregation Principle (ISP)
Clients should not be forced to depend on methods they do not use.
Implementation: The GameCommand interface contains only execute() and undo(). It does not force commands to implement unnecessary methods like serialize() or logAnalytics().
Benefit: Keeps the CommandManager lightweight and focused.
3.5. Dependency Inversion Principle (DIP)
High-level modules should not depend on low-level modules. Both should depend on abstractions.
Implementation: The MoveCommand (Business Logic) does not depend on HomePageState (UI). Instead, it depends on the CommandReceiver interface.
Benefit: Allows unit testing of game moves without launching the Flutter graphical interface.

4. User Manual
Getting Started
Launch the application.
In the Main Menu, select a game mode:
Standard Game: Classic 4x4 experience.
Challenge Mode: Harder start, limited undos.
Optionally, change the grid size in the "Grid Size" menu (3x3 to 6x6).
Gameplay
Objective: Swipe (Up, Down, Left, Right) to merge tiles with the same number to reach 2048.
Controls:
↩️ Undo: Reverts the last move (uses Command pattern).
🎨 Theme: Changes the visual style of tiles instantly.
🔄 New Game: Resets the current session.
5. Conclusion
The 2048 Flutter project demonstrates a professional approach to mobile application development. The use of Factory, Command, Decorator, and Singleton patterns ensures architectural flexibility, allowing new features to be introduced without refactoring the core logic. The project fully complies with modern industry standards (Clean Architecture, SOLID).


```text
lib/
├── command/                   # Command Pattern 
│   ├── command_interface.dart
│   ├── command_manager.dart
│   └── move_command.dart
├── game_engine.dart           # Logic of the game
├── game_factory.dart          # Factory Method Pattern
├── home.dart                  # Game screen
├── main.dart                  # Entry point
├── main_menu.dart             # Main menu
├── score_manager.dart         # Management with scores 
└── tile_component.dart        # Decorator Pattern 

<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/c6fc598b-3687-48ac-a70a-259eb108d98c" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/93148032-b7f5-44df-bc5a-8e6d32ec1ce3" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/78c4b1db-18b9-4544-ae93-8f58cbfd02e6" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/191d3f0c-819c-4715-bc5a-62b94d613ca9" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/05edf2b7-e71b-4ebd-abfa-37070e856180" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/6da2edd7-721b-4cf8-86e8-d5a44f812a05" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/b823a6cd-7652-4557-ab4f-e3be9be297d2" />
<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/8b3bab1e-4b9f-477e-b1b3-bf9141e0a02e" />









Nurdaulet - Архитектура, паттерны проектирования
Dilyara - UI/UX, игровая логика
Khanbibi - Тестирование, документация
