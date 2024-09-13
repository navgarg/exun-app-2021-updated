# exun_app_21
Basic App originally made by me in 2021 to coordinate the annual inter-school tech symposium of Exun Clan, the tech club of Delhi Public School, R K Puram.

Recently revamped completely to include more features and increase usability.

Demo credentials for app:
- member - email: `member@gmail.com`; password: `123456`
- admin - email: `admin@exunclan.com`; password: `123456`

## Features

### Login/Signup
- Uses `FirebaseAuth` for authentication. Checks for validity of all fields before signup.
- 2 types of users: admins and members. Admins have additional functionality.
- Admins cannot sign up. They have to be added by another admin.

&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/login_screen.jpeg?raw=true" height="550">&emsp;&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/signup_screen.jpeg?raw=true" height="550">

### Navigation Drawer
&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/nav_bar.jpeg?raw=true" height="550">

### Schedule
- Uses `SfCalendar` to show scheduled upcoming events on calendar.
- Gets event data from .json file.
- User has option of participating in any event. On participating, user will be able to see notifs related to the event.
- Uses `add_2_calendar` to add schedule to user's default calendar.

&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/schedule_screen.jpeg?raw=true" height="550">&emsp;&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/schedule_dialog.jpeg?raw=true" height="550">&emsp;&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/add_to_cal.jpeg?raw=true" height="550">


### Exun Talks
- Shows a list of past Exun Talks. Exun Talks are a series of semi-professional sessions relating to technology, with speakers including Exun and DPS RKP alumni, YouTubers among others.
- Uses `YoutubePlayer` to embed YouTube videos.
- Gets talks data from firestore.

&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/talks_screen.jpeg?raw=true" height="550">&emsp;&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/talk_page.jpeg?raw=true" height="550">
### Notifications
- Shows list of important notifications related to the events user has participated in. Admin can add notifications.
- Admin gets notifications related to all events, as he manages all.
- Gets notifs data and writes new notifs to Firebase Cloud Firestore.

&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/notifs_screen.jpeg?raw=true" height="550">&emsp;&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/notifs_admin.jpeg?raw=true" height="550">

### Members, Alumni, Faculty
- Uses nested `ListView.builder` for displaying all data in separate screens.
- Gets data from .json file for each screen.

&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/members_screen.jpeg?raw=true" height="550">&emsp;&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/alumni_screen.jpeg?raw=tru" height="550">&emsp;&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/faculty_screen.jpeg?raw=true" height="550">


### Contacts
- Gets contacts data from .json file.
- Opens queries page when `ListTile` is clicked.
- Uses `email_validator` for validation of emails. Writes queries with correct emails to Firestore.

&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/contact_screen.jpeg?raw=true" height="550">&emsp;&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/query_screen.jpeg?raw=true" height="550">

### My Events
- Shows list of all events user has participated in.
- Admin automatically participates in all events, so as to manage them.

&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/my_events.jpeg?raw=true" height="550">

### Profile
- Shows email and name for user
- Feature to add admin for admins

&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/profile_member.jpeg?raw=true" height="550">&emsp;&emsp;<img src="https://github.com/navgarg/exun-app-2021-updated/blob/master/screenshots/profile_admin.jpeg?raw=true" height="550">