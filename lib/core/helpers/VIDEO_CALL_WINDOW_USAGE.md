## How to Open Video Call in New Window

To open a video call in a new browser window (like Messenger), use the `VideoCallWindowHelper`:

```dart
import 'package:projectflow_web/core/helpers/video_call_window_helper.dart';

// When user clicks to join meeting
VideoCallWindowHelper.openVideoCallWindow(
  meetingId: meeting.id,
  width: 1280,  // optional, default: 1280
  height: 720,  // optional, default: 720
);
```

### Example Usage in a Meeting List:

```dart
ElevatedButton(
  onPressed: () {
    // Open video call in new window
    VideoCallWindowHelper.openVideoCallWindow(
      meetingId: meeting.id,
    );
  },
  child: Text('Join Call'),
)
```

The video call will open in a centered popup window without the sidebar/navigation.
