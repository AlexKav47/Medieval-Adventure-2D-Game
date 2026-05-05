# Medieval Pixel Platformer

A 2D medieval pixel-art platformer made in Godot. The game features a playable character, animated enemies, coin collection, health, sound effects, background music, win/loss menus, and a main menu system.

## Gameplay

The player explores a medieval-style level, collects coins, avoids enemies, and tries to collect all 10 coins to win. Slimes patrol the level and attack the player on contact. The player has 3 health and can attack slimes to defeat them.

Gameplay video coming soon.



## Features

- 2D pixel-art medieval level
- Player movement with A/D controls
- Jumping with Space
- Player attack system
- Slime enemy AI
- Enemy patrol with wall and floor detection
- Player health system with 3 health
- Coin counter: `Coins 0/10`
- Win condition after collecting all coins
- Game over screen when the player dies
- Play Again, Main Menu, and Exit buttons
- Main menu with Play and Exit buttons
- Sound effects for:
  - Button clicks
  - Coin collection
  - Player jump
  - Player hurt
  - Slime death
- Background music during gameplay

## Controls

| Action | Key |
|---|---|
| Move Left | A |
| Move Right | D |
| Jump | Space |
| Attack | Left Mouse Button |

## Built With

- Godot 4
- GDScript
- Pixel Art Assets
- WAV sound effects and background music

## Project Structure

```text
project/
├── scenes/
│   ├── main_menu.tscn
│   └── game.tscn
├── scripts/
│   ├── player.gd
│   ├── slime.gd
│   ├── coin.gd
│   └── main_menu.gd
├── sounds/
│   ├── coin.wav
│   ├── explosion.wav
│   ├── hurt.wav
│   ├── jump.wav
│   └── tap.wav
├── sprites/
└── README.md
