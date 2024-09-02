# exun_app_21
Basic App originally made for Exun event 2021. Revamped to include more features and increase usability.

## Features

### Schedule
- Shows upcoming events.
- Uses `SfCalendar` to show scheduled events on calendar.
- Gets event data from .json file.

### Exun Talks
- Shows a list of past Exun Talks.
- Uses `YoutubePlayer` to embed YouTube videos.
- Gets talks data from .json file.

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
