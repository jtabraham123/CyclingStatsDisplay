# CyclingStatsDisplay

<img src="CyclingStatsDisplay/stravaApp.gif" alt="Demo of the feature" width="500" height="1084"/>

# Build Instructions

1. First clone the repository with `git clone git@github.com:jtabraham123/CyclingStatsDisplay.git` (if you have git ssh setup) or `git clone https://github.com/jtabraham123/CyclingStatsDisplay.git` for git https

2. Then open Xcode, click open existing project and open the project in the directory where you cloned it

3. Make sure to have Xcode signing setup https://developer.apple.com/documentation/xcode/sharing-your-teams-signing-certificates

4. Then click on iPhone 16 simulator in the top bar or plug in a physical device to use if you prefer

5. Then click the play button to build/run it.

Note: If using iOS 18 on the simulator, when oauth is brought up it may ask for the iphone passcode just enter any numbers and it should work

# Future Improvements 

- Following step 3 of the Strava Brand guidelines: says to link your data back to Strava with a "view on Strava" label https://developers.strava.com/guidelines/
  - Though I followed all of the other Brand guidelines

- Graphic Design for the UI could be improved, i made most of the UI fairly quickly and authentication took most of my time

- Unit Tests should be added to ensure functionality is operating correctly

- Error Handling/Error display: Errors in the authentication service file do not show for the user. Therefore, if there are any errors in the authentication process, the user will not see this on the display and will be stuck on the initial login screen

- Redirect for specific URL: Currently, the url redirect after authenticating with the app works well, but any url with the scheme CyclingDisplayApp:// entered from the browser will trigger this function to be called, so making sure the specific authentication redirect url was called before proceeding with making the authentication http request would be a more polished approach

- Loading Screen after url Authentication: Some screen indicating to the user that they are done with url authentication and are awaiting the authentication POST request to give the Access Token to access their ride data (currently it just links back to the login screen and waits until the POST request completes to navigate to the next page). Someone could probably trigger some glitchy behavior if they managed to click the "connect with Strava" button again before the authentication POST request completes.

- The StravaAPIService could be modified to make periodic requests to the api if the users wanted data to update while they had their app open but in the background, would invlove using the refresh token to keep a user logged in.

- The strava API access details could be put in a global environment file in case any other files had to use it or if I wanted to hide it from github. It is a slight security flaw to expose the api info though it makes it easier to run as you do not need to create a Strava API access account and enter in these details yourself to run it.
