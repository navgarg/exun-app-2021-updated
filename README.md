# exun_app_21
Basic App originally made for Exun event 2021. Revamped to include more features and increase usability.

## Features

### Login/Signup
- Uses `FirebaseAuth` for authentication.
- Uses `role` property to distinguish between admins and members.
- Admins cannot sign up. They have to be added by another admin.
- Credentials for app: 

### Schedule
- Shows upcoming events.
- Uses `SfCalendar` to show scheduled events on calendar.
- Gets event data from .json file.

### Exun Talks
- Shows a list of past Exun Talks.
- Uses `YoutubePlayer` to embed YouTube videos.
- Gets talks data from firestore.

### Notifications
- Shows list of important notifications.
- Gets notifs data from Firebase Cloud Firestore.

### Members
- Uses nested `ListView.builder` for displaying all members from different classes.
- Gets members data from .json file.

### Alumni
- Uses nested `ListView.builder` for displaying all alumni from different years.
- Gets alumni data from .json file.

### Faculty
- Uses nested `ListView.builder` for displaying all faculty members.
- Gets faculty data from .json file.

### Contacts
- Gets contacts data from .json file.
- Opens queries page when `ListTile` is clicked. 
- Uses `email_validator` for validation of emails. Writes queries with correct emails to Firestore.
