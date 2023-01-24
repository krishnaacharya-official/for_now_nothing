/**bug: If you switch of interent and try to refresh in the middle of the screen
 * lets say inside some category, then it refreshes but the params are lost
 * So you'll get weird image fails errors in the image widget
 * You have to redirect to the home page
 * 
 * So when this happens and you redirect to the home Page using bakcbutton
 * the navigation button is puff gayab.
 */
/**bugs: Retry will crash the app in any category screen because they need props to be passed which will be null
 * even if the data is fetched from the internet
 */

/**bug: When the app is closed the profile screens state doesn't persist and behaves very strangely
 *  with saave button and the avatar as well */

// I guess the above error is handled

/**bugs: If only phone number is entered and otp isn't verified .
 *  When you restart it will still take you to homescreen
 * 
 */

/**bugs: If you log out from a user and exit app and come back
 * I dont think you'll be redirected to the signIn screen, 
 * Because phone doesn't get redirected if i manually delete the user in firebase
 * 
 */

/**Just check once with onResume state of the app, if everything works fine
 * Or is there any delay, if there is how would you tackle.
 */

/** When you try to mess around with the address the profile 
 * i.e UserState.userModel is fucked up and 
 * It becomes null :)
 */
/**
 * Check that every line if extended how it looks it shouldn't overflow
 * Or it shouldn't look crazy the address screen 
 */
/**
 * See all the sizes if it doesn't overflow, 
 * products for example the layout does it scale good in every screen
 * If not make it responsive for all the devices, but you should see there
 * should not be any chances of having a overflow error, nothing should be 
 * hardly coded for that to happen.
 */
