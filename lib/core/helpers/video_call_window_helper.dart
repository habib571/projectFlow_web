import 'dart:html' as html;

class VideoCallWindowHelper {
  /// Opens the video call in a new browser window/tab
  /// [meetingId] - The ID of the meeting to join
  /// [width] - Width of the popup window (default: 1280)
  /// [height] - Height of the popup window (default: 720)
  static void openVideoCallWindow({
    required int meetingId,
    int width = 1280,
    int height = 720,
  }) {
    // Get current origin (e.g., http://localhost:port or your domain)
    final currentOrigin = html.window.location.origin;
    
    // Construct the URL for the video call page
    final videoCallUrl = '$currentOrigin/#/video-call/$meetingId';
    
    // Calculate center position for the popup
    final left = (html.window.screen!.width! - width) ~/ 2;
    final top = (html.window.screen!.height! - height) ~/ 2;
    
    // Window features for the popup
    final features = [
      'width=$width',
      'height=$height',
      'left=$left',
      'top=$top',
      'toolbar=no',
      'menubar=no',
      'scrollbars=no',
      'resizable=yes',
      'location=no',
      'status=no',
    ].join(',');
    
    // Open the new window
    html.window.open(videoCallUrl, 'VideoCall_$meetingId', features);
  }
}
