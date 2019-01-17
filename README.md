# Project Utility Application
Team Project by team The World!

Trello link: https://trello.com/b/FEhpeJil/ecs189-project

Group members: Jack Feng, Weiran Guo, Yuanbo Li

Weiran Guo <br />
github id: panunburn <br />
<img src="./pic/weiran.jpg" alt="Weiran" width="300"/>


Yuanbo Li <br />
github id: yuanboli <br />
<img src="./pic/yuanbo.jpg" alt="Yuanbo" width="400"/>

Jack Feng <br />
github id: QuantumJack <br />
<img src="./pic/jack.jpg" alt="Jack" width="400"/>


## Usage
This App is optimized for iPhone XR.
To test our App, first build from xcode. For demo purpose, we **set the next 8 hours of your current location rainning**.

![Alt Text](https://github.com/ECS189E/utilityApp/blob/master/demo/image1.gif)

Swipe up from main page to access your calendar. Different calendar has different color label. For the upcomming 48 hours (including this hour), all the events with specific weather condition will have a icon on the right side (e.g. An umbrella if it will be rainning).
To delete one of your events, you can simply long-press the event and choose the delete button displaying in the app. This event will also be deleted from your calendar as well.

![Alt Text](https://github.com/ECS189E/utilityApp/blob/master/demo/image2.gif)

One of the most important feature for our App is that user can schedule their tasks according to the weather information. And this whole process is automatic. For example, if user want to schedule a time to play soccer, he/she can simply press the "+" button on the top right cornor of the calendar view, and then select an appropriate time interval for this activity, set how long he/she wants to play soccer, indicate this will be an ourdoor event. Then our application will automatically select a time period inside the given interval and avoid the bad weather for this event.

![Alt Text](https://github.com/ECS189E/utilityApp/blob/master/demo/image3.gif)

Similarly we can schedule indoor event, which will not be affected by weather. Also, if we choose a specific location, our scheduler will schedule the task according to the weather at that specific location

![Alt Text](https://github.com/ECS189E/utilityApp/blob/master/demo/image4.gif)

## API Usage
### Weather Info Query
We use Dark Sky services for weather info API: https://darksky.net.

We use the API in the most efficient way, since we query the weather info at the very beginning of the app, and restore the info to avoid redundant call of APIs. We only query API multiple times when user requires weathers for different locations (e.g. user schedule a task for different location and we will need weather info for that location).
## Member Contribution
Yuanbo Li: Implement the weather detail page, calendar page

Weiran Guo: Implement the Weather Query API, calendar add event page

Jack Feng: Implement the main weather page, help improve the weather detail page
## Phone Credit:
"cloudy_background": Photo by Daoudi Aissa on Unsplash

"sunny_background": Photo by Zain Bhatti on Unsplash

"rainy_background": Photo by Valentin Müller on Unsplash

"night_background": Photo by Casey Horner on Unsplash

AppIcon: Photo by rawpixel on Unsplash

Icons made by Freepik from www.flaticon.com is licensed by CC 3.0 BY


