# Characters
 
A modularized project using clean code architecture for characters list of Rick and Morty.

## Modules

### Network 
This modules is responsible handling all APIs requests.

### Common
This module is for sharing models and interfaces among all modules.

### Data
This is responsible for all data using Repositories

### Business
This is for domain logic using UseCases

### CharacterList 
This is representation layer for Character List. it uses builder to return view controller.

### CharacterDetails
This is representation layer for Character Details. it uses builder to return view controller.

## Navigation
This class is responsible for navigation between all modules and sending data between them.
There is an interface in Common Module, so any module can consume it.
## Assumptions and Decisions
- Filter data come from first page of API response.
- After selection filter type, reset page number
- When select filter cell again, it deselected. 
## Build Instructions
Open Xcode Project
## Unit Tests
Character List View Model test cases are added with 79% test coverage.
