# Sprint Note 3
Dec 3rd

### Trello Board Link
https://trello.com/b/FEhpeJil/ecs189-project

### Yuanbo Li
#### What I did:
1. implement the calendar page UI view controller, using a multiple section collection view controller to represent a calendar. see: https://github.com/ECS189E/utilityApp/commit/08b22834b3bf5ec350fbf5a9ea78a0940325ed71
2. Implement the transition between main view controller to the calender view controller, using a user gesture recognizer to capture the swipe-up user behavior, and then perform the transition. see:https://github.com/ECS189E/utilityApp/commit/fba08c5199782d801a6dc7df565c342ca4d9a500
3. started weather tip UI page. see: https://github.com/ECS189E/utilityApp/commit/02930e6b6e83eb1d6854e96d66de805fb68b56ff

#### What I plan to do:
1. correct the bug of using weather parser API incorrectly.
2. Finish the weather tip section

#### Issues that I have:
1. Need a better data passing flow to pass weather info among view controllers, need redesign the mechanism.

### Weiran Guo
#### What I did:
1. Load calendar functionality and update collection view cells. 
https://github.com/ECS189E/utilityApp/commit/169f44e1edfdefbd895fe99de7574be591cec437
2. Add calendar functionality when hit the add button.
https://github.com/ECS189E/utilityApp/commit/3d87eb8a0bf7752e182b12655bbc8ea8d5994ae4

#### What I plan to do:
1. Add add calendar UI page.
2. Add user suggestion based on weather data after user create a new event inside the App.

#### Issues that I have:

### Jack Feng
#### What I did:
1. Update collection view cells and make them looks like the real ios11 weather app.
2. Add beautiful icon to the app, with high-quality image for the large Image.
commit: https://github.com/ECS189E/utilityApp/commit/c8c972e4ccebc46bf09ac3c72e512d7f3772654d

#### What I plan to do:
1. Finished a delegate for each controll view cell and add functionality: getting weatherApi's json data, parse it down
2. Get them into a weather-hourly and/or weather-weekly structure
3. Show each weather-hourly in the cell of collection view of UI

#### Issues that I have:
Unexpected bugs and error when implement and call weatherApi in the collection view, so I've decided to find a new way. In general, I met some difficulties calling the Api.
