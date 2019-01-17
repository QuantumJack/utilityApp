# SprintNote 2
November 26th, 2018

## Trello Board Link
https://trello.com/b/FEhpeJil/ecs189-project

### Weiran Guo:
#### What I did before this meeting
1. updated WeatherAPI.swift. I used asyncronization to create the API struct, so the returned json weather data can be used easily by other functions.
2. Created new WeatherParsed.swift. This file parse the json weather info and return all useful infomation. User can access these info by creating a class variable and call the API.
3. GPSInfo.swift. The GPS struct will return user gps info(latitude, longitude) in tuple. It will ask user for permission first, then it will give location info to caller. This struct is called by WeatherAPI.swift.

#### What I plan to do
Merge code to main branch.
Add notification for the App. Inform the user the weather when they are not using the App.
Add functionality that user can add and delete city they want. Currently The location is the default user location. 

#### Issues I have

### Yuanbo Li
#### What I did
1.	I finish the DetailedWeather view controller, which display the detailed weather information. I add a header to the collection view to display the major information of the day.
2.	Due to the massive merge conflict we have, I turned the view controller in storyboard into code to avoid the merge conflict.
3.	Create customized header and collectionview cell to display info.
4.	Implement the navigation between the main view controller to the detailed view controller

Commit Link: https://github.com/ECS189E/utilityApp/commit/27fa2a3e38bcd1ce168e6204bcb778a95ff8120e 
#### What I plan to do
1.	I plan to implement the weather view change for multiple address by capturing user gesture.
2.	I will also use API to gather true weather info to fill the collection view
#### The Issue I have
1.	Have a had time to figure out how to make a resizable collection view header to make it always existing in the top half of the screen, still in progress to refine the UI.

### Qixuan Feng:

#### What I did before this meeting
1.	Implement an UI design for one local weather. I use a seperate view block to show the place and today's weather and temperature data with enlarged font.

2.	Implement an UI design for 24 hourly weather information. I use a collection view with specified cell to show the time(hour), weather icon(e.g. cloudy or partly sunny etc.) and temperature per hour.

3.	Implement an UI design for weekly data information. I use another collection view with new specified cell to show the weekday, weather, and temperature range.

I've merge code to main branch.

Commit Link: https://github.com/ECS189E/utilityApp/commit/f2889100025e1bb7c47c6cc4424154d34e66ab3a

#### What I plan to do
1.	polish some details about the UI to make it more stable and beautiful
2.	I will change the weekly UI to a better vertical-down collection view
3.	I will also use API to gather true weather info to fill the collection view of hour and weekday
4.	Change storyboard code to coding because of Git group problem and for convenience of code reuse

#### The Issue I have
1.	The UI is not convincing, and need to layout smarter using hard code
