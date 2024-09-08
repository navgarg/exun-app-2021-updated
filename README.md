# exun_app_21
Basic App originally made for Exun event 2021. Revamped to include more features and increase usability.

## Features

### Login/Signup
- Uses `FirebaseAuth` for authentication.
- Distinguishes between admins and members.
- Admins cannot sign up. They have to be added by another admin.
- Demo credentials for app:
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/login_screen.jpeg?raw=true)
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/signup_screen.jpeg?raw=true)

### Schedule.
- Uses `SfCalendar` to show scheduled events on calendar.
- Gets event data from .json file.
- User has option of participating in each event. On participating, user will be able to see notifs related to the event.
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/schedule_screen.jpeg?raw=true)
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/schedule_dialog.jpeg?raw=true)

### Exun Talks
- Shows a list of past Exun Talks.
- Uses `YoutubePlayer` to embed YouTube videos.
- Gets talks data from firestore.
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/talks_screen.jpeg?raw=true)

### Notifications
- Shows list of important notifications according to the events user has participated in.
- Gets notifs data from Firebase Cloud Firestore.
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/notifs_screen.jpeg?raw=true)

### Members, Alumni, Faculty
- Uses nested `ListView.builder` for displaying all data in separate screens.
- Gets data from .json file for each screen.
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/members_screen.jpeg?raw=true)
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/alumni_screen.jpeg?raw=true)
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/faculty_screen.jpeg?raw=true)

### Contacts
- Gets contacts data from .json file.
- Opens queries page when `ListTile` is clicked. 
- Uses `email_validator` for validation of emails. Writes queries with correct emails to Firestore.
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/contact_screen.jpeg?raw=true)
  ![alt text](https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/query_screen.jpeg?raw=true)
