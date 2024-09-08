# exun_app_21
Basic App originally made for Exun event 2021. Revamped to include more features and increase usability.

## Features

### Login/Signup
- Uses `FirebaseAuth` for authentication.
- Distinguishes between admins and members.
- Admins cannot sign up. They have to be added by another admin.
- Demo credentials for app: 

### Schedule.
- Uses `SfCalendar` to show scheduled events on calendar.
- Gets event data from .json file.
- User has option of participating in each event. On participating, user will be able to see notifs related to the event.

### Exun Talks
- Shows a list of past Exun Talks.
- Uses `YoutubePlayer` to embed YouTube videos.
- Gets talks data from firestore.

### Notifications
- Shows list of important notifications according to the events user has participated in.
- Gets notifs data from Firebase Cloud Firestore.

### Members, Alumni, Faculty
- Uses nested `ListView.builder` for displaying all data in separate screens.
- Gets data from .json file for each screen.

### Contacts
- Gets contacts data from .json file.
- Opens queries page when `ListTile` is clicked. 
- Uses `email_validator` for validation of emails. Writes queries with correct emails to Firestore.
