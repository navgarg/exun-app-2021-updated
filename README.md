# exun_app_21
Basic App originally made for Exun event 2021. Revamped to include more features.

## Features

### Schedule
- Screen to show upcoming events.
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
- Shows list of current Exun Clan members.
- Uses nested `ListView.builder` for displaying all members from different classes.
- Gets members data from .json file.
