# Technical Notes

## Architecture
- Autoload managers centralize shared state and gameplay concerns.
- Scene scripts handle UI and flow.
- Minigames inherit from the reusable base class for consistent timing and feedback.

## Expansion Plan
- Add new minigame scripts under scripts/minigames/.
- Register new challenge data in data/minigames.json.
- Extend UI and progression systems as the game grows.
