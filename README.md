# Character App

Welcome to Characters! This is a simple iOS application for viewing a paginated list of characters with the ability to filter them by their status (Alive, Dead, or Unknown). Users can also view detailed information about any of the characters.

## Important Notes

- The UI link didn't open, so I attempted to replicate the designs as closely as possible.
- Deployment Info is iOS 17.0.
- A network layer was added to demonstrate scalability, although a simpler solution could have submitted.

## Challenges

- Using Compositional Layout caused unnecessary updates to the statuses section, resulting in bugs. To address this, I opted for reloading/inserting updates to the characters section instead of using the collection view's reloadData method.

## Dependencies

- **Alamofire:** Networking
- **Kinngfisher:** Downloading Images 
- **SnapKit:** Layout

## Assumptions

- Character background color is set based on gender.
- Character name truncated as two lines look good.
- Support for landscape and iPad designs is not necessary.

## Tests
- **UI Tests**: Adding an item and searching for it simple test is adding for both CoreData(main branch) and SwiftUI(swift-data branch) 
- **Unit Tests**: Added tests for Netwrok Layer, Image Provider and Characters List View Model
- **Maunal Tests**: Manual Testing is conducted to make sure all requirements are met
- **Memory Leaks Tests**: Memory leaks checks using Instruments(main branch) with zero memory leaks

## Enhancements To Be Added

- **Separation Of Different Error Types (Netwrok - Server -Client)**
- **Response Caching**
- **Localization Support**
- **Better Error State Handling**

## Technologies Used

- **UIKit**: Characters List Screen
- **SwiftUI**: Character Details Screen

## Screenshots

<img src="https://github.com/mohamedfarid1993/Characters/assets/37486139/687a149f-9876-4c1c-9df8-7a0c201427ca" alt="Screenshot 1" width="300">
<img src="https://github.com/mohamedfarid1993/Characters/assets/37486139/6d0813e0-4556-4fa3-aed9-543fb1368c1c" alt="Screenshot 2" width="300">
<img src="https://github.com/mohamedfarid1993/Characters/assets/37486139/0c27fde9-cbf0-45e9-a184-dddd40873388" alt="Screenshot 3" width="300">

## Getting Started

To get started with the project, follow these steps:

1. Clone the repository to your local machine:

```bash
git clone https://github.com/mohamedfarid1993/Characters
