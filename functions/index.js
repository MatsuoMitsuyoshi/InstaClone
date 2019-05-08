const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.helloWorld = functions.https.onRequest((request, response) => {
 response.send("Hello from Firebase!");
});

exports.sendPushNotification = functions.https.onRequest((req, res) => {

  res.send("Attempting to send push notification")
  console.log("LOGGER --- Trying to send push messaage..");

  var uid = 'onxXHlMElEU1QT5FHGsFthznrWc2'

  var fcmToken = 'fgSpyh8jag8:APA91bFBcfDFvVovur2MUFH5tyjnNmVkHKkQ5_LqdZ3pHAc8S3avdBEiEwyTnekbuUuoemoixPvQe45sP7_1bWX0bDPkao_ecxyBX-xDi30nQTMFDfuu3NwWixIEagOsC4TtGqULJFF5'

  return admin.database().ref('/users/' + uid).once('value', snapshot => {

    var user = snapshot.val();

    console.log("Username is " + user.username );

    var payload = {
      notification: {
        title: 'Push notification title',
        body: 'Test notification messaage'
      }
    }

    admin.messaging().sendToDevice(fcmToken, payload)
      .then(function(response) {
        // Response is a message ID string.
        console.log('Successfully sent message:', response);
      })
      .catch(function(error) {
        console.log('Error sending message:', error);
      });
  })
})
