import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  likedPost,
  likedComment,
  addedPost,
  addedComment,
  bookingMade,
  groupJoined,
}

abstract class Notification {
  String text;
}

class CommentPostNotification implements Notification {
  String imageURL, refID, textSnipped, refName;
  Timestamp date;
  String type;
  final NotificationType notificationType;

  CommentPostNotification(this.refName, this.refID, this.imageURL, this.date,
      this.textSnipped, this.notificationType) {
    switch (notificationType) {
      case NotificationType.likedComment:
        text = 'you liked a comment in ' + refName;
        break;
      case NotificationType.likedPost:
        text = 'you liked a post in ' + refName;
        break;
      case NotificationType.addedComment:
        text = 'you left a commment in ' + refName;
        break;
      case NotificationType.addedPost:
        text = 'Post added in ' + refName;
        break;
      case NotificationType.groupJoined:
        text = 'You have joined the group ' + refName;
        break;
      case NotificationType.bookingMade:
        text = 'Appointment made successfully with' + refName;
        break;
    }
  }
  @override
  String text;

  Map<String, dynamic> toJSON() {
    return {
      'text': text,
      'reference_name': refName,
      'reference': refID,
      'image': imageURL,
      'date_created': date,
      'text_snipped': textSnipped
    };
  }

  Map<String, dynamic> toFunctionJSON() {
    return {
      'text': text,
      'reference_name': refName,
      'reference': refID,
      'image': imageURL,
      'date_created': null,
      'text_snipped': textSnipped
    };
  }
}
