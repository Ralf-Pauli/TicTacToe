# Tic Tac Toe Game

Welcome to the Tic Tac Toe game! This project is a simple implementation of the classic Tic Tac Toe game using the LOVE 2D game framework. The game supports both player-vs-player and player-vs-CPU modes.

## Features
- **Player vs Player Mode**: Play against another person locally.
- **Player vs CPU Mode**: Challenge the CPU with a basic AI implementation.
- **Dynamic Gameplay**: The CPU can make strategic moves to challenge the player.
 **Interactive UI**: Simple and intuitive interface for gameplay.

## Files Overview

### [main.lua](fleet-file:///GameDev/Projects/TicTacToe/main.lua?hostId=61thj348bsh5ptm89076&root=E:&offset=0&type=file)
This is the main game logic file. It includes:
 Initialization of the game grid.
 Handling player and CPU moves.
 Detecting win/draw conditions.
 Drawing the game grid and interactive buttons.
 Resetting the game state.

### [cpu.lua](fleet-file:///GameDev/Projects/TicTacToe/cpu.lua?hostId=61thj348bsh5ptm89076&root=E:&offset=0&type=file)
This file implements the CPU logic. It includes:
 Enabling/disabling the CPU.
 Finding the best move for the CPU based on scoring and win/draw detection.
 Random move generation if no strategic move is found.

### [conf.lua](fleet-file:///GameDev/Projects/TicTacToe/conf.lua?hostId=61thj348bsh5ptm89076&root=E:&offset=0&type=file)
This file configures the LOVE 2D framework. It includes:
 Enabling the console for debugging purposes.

## How to Run

1. Ensure you have the LOVE 2D framework installed. You can download it from [LOVE2D.org](https://love2d.org/).
2. Clone this repository to your local machine using the following command:
   ```sh
   git clone https://github.com/username/repository-name.git
   ```
3. Open the cloned project directory in your preferred text editor to inspect or modify the code.
4. Execute the game using the LOVE 2D framework by following these steps:
   - Open your terminal and navigate to the cloned project directory:
     ```sh
     cd path_to_project_directory
     ```
   - Run the LOVE 2D executable with the project directory as an argument:
     ```sh
     path_to_love_executable .
     ``` 
   Note: Replace `path_to_love_executable` with the actual path where the LOVE 2D executable is installed on your system.

## Controls

- **Left Mouse Click**: Make a move on the grid or toggle CPU mode.
- **Interactive Button**: Enable/Disable CPU mode during gameplay.

## Game Rules

 Players take turns marking a cell in a 3x3 grid.
 The first player to align three of their marks in a row, column, or diagonal wins.
 If all cells are filled without a winner, the game ends in a draw.

## Dependencies

 **LOVE 2D Framework**: Required to run the game.

## License

This project is open-source and available under the MIT License.
