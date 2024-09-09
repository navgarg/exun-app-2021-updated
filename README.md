# exun_app_21
Basic App originally made for Exun event 2021. Revamped to include more features and increase usability.

## Features

### Login/Signup
- Uses `FirebaseAuth` for authentication. Checks for validity of all fields before signup.
- Distinguishes between admins and members.
- Admins cannot sign up. They have to be added by another admin.
- Demo credentials for app: email: `navgarg06@gmail.com`; password: `123456`

  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/login_screen.jpeg?raw=true =250x)	![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/signup_screen.jpeg?raw=true =250x)

### Schedule
- Uses `SfCalendar` to show scheduled events on calendar.
- Gets event data from .json file.
- User has option of participating in each event. On participating, user will be able to see notifs related to the event. 
- Uses `add_2_calendar` to add schedule to user's default calendar.

  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/schedule_screen.jpeg?raw=true =250x)	![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/schedule_dialog.jpeg?raw=true =250x)


### Exun Talks
- Shows a list of past Exun Talks.
- Uses `YoutubePlayer` to embed YouTube videos.
- Gets talks data from firestore.

  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/talks_screen.jpeg?raw=true =250x)

### Notifications
- Shows list of important notifications according to the events user has participated in.
- Gets notifs data from Firebase Cloud Firestore.

  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/notifs_screen.jpeg?raw=true =250x)

### Members, Alumni, Faculty
- Uses nested `ListView.builder` for displaying all data in separate screens.
- Gets data from .json file for each screen.

  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/members_screen.jpeg?raw=true =250x)	![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/alumni_screen.jpeg?raw=true =250x)	![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/faculty_screen.jpeg?raw=true =250x)


### Contacts
- Gets contacts data from .json file.
- Opens queries page when `ListTile` is clicked.
- Uses `email_validator` for validation of emails. Writes queries with correct emails to Firestore.
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/contact_screen.jpeg?raw=true =250x)	![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/query_screen.jpeg?raw=true =250x)
  
