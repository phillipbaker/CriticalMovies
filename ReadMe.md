# Critical Movies

An iOS app that displays New York Times movie reviews with a focus on Critic’s Picks.

The motivation for this app was driven by a few separate things. I wanted to make something with UIKit. I wanted to explore modern collection views, diffable data source and compositional layouts. I thought something content-based would be a good fit and I love movies. 

&nbsp;
&nbsp;

![cm-collage-3](https://github.com/phillipbaker/CriticalMovies/assets/16352712/906b2d7a-be6b-44fa-b7de-e0ad3a83e71b)

&nbsp;
&nbsp;

## Features & Technologies

- **Swift**
- **UIKit**
- **Auto Layout**
	- Two separate collection view cells that accommodate a resizing image, two multiline labels and a conditional label.
- **Model-View-Controller (MVC)**
	- Implemented MVC with multiple delegates for communication between layers.
- **UICollectionView**
	- Diffable data source, injectable collection view cell.
	- Adapts to screen sizes and orientations with compositional layouts.
- **Networking** 
	- Migrated from a deprecated New York Times API.
	- Decoupling data loading behaviour from the collection view.
	- Refactored to remove networking Singleton and separate data and image loading classes.
- **Unit Tests**
	- Unit-tested view controllers, search controller, collection view and networking using XCTest.
- **Search**
	- Implemented search of all New York Times movie reviews. Those that were awarded a Critic’s Pick are labelled.
- **Infinite Scroll**
	- Paginated network requests and error handling.
	- Displays a message to the user when there are no more results.
