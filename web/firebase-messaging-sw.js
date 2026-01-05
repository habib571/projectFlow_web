importScripts("https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js");

firebase.initializeApp({
   apiKey: "AIzaSyBD50KNXcfZFxy7OFjLWYYpCQP7eMrbjMs",
      authDomain: "projetcflow-fc8d2.firebaseapp.com",
        projectId: "projetcflow-fc8d2",
      storageBucket: "projetcflow-fc8d2.firebasestorage.app",
      messagingSenderId: "57172660323",
      appId: "1:57172660323:web:8835953741641bdd522856",
      measurementId: "G-Y5RLKYCTBE"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
    console.log('[firebase-messaging-sw.js] Received background message ', payload);

    const notificationTitle = payload.notification?.title || payload.data?.title || 'New Message';
    const notificationOptions = {
        body: payload.notification?.body || payload.data?.body || '',
        icon: '/icons/Icon-192.png',
        badge: '/icons/Icon-192.png',
        data: payload.data
    };

    return self.registration.showNotification(notificationTitle, notificationOptions);
});