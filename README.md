# GameListApp

### Requirements:

This app developed in Xcode 15.0.1 and tested in iOS simulator iOS 17.0.
Minimum deployment target is 13.0

### Features:

- Collectionview is used in first tab to provide 2 columns in landscape mode.
- When images are fetched, they are saved in document directory and used if it is same name.
- Pagination support is provided in main page as well as that used in search flow.
- For adding to favorites in the details page, you should tap to favorites button in top bar.
- These favorites can be seen in favorites tab and you can delete any favorite game by swiping and tapping delete button.
- Unit tests implemented just Favorites page but all view models were made testable.
- The base url was defined in build settings.

### Questions & Answers

- I have used MVVM to make testable code and I paid attention to use interfaces in modules. All parts can be tested with mockable data.
- Image fetching in cells can be improved and more effective. Cache mechanism can be added.
- I enjoyed in creating class part and designing system.
- This app is not ready for store. Design is main problem and the app have some performance issues in search.
- I setted minimum target is iOS 13 because of that give me error in some places like app delete and I didn't want to add version annotions. So, you may update such this the document is minimum iOS 13 or above.