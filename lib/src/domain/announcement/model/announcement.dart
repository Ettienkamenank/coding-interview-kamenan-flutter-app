import 'package:coding_interview_flutter_app/src/domain/activity_area/model/activity_area.dart';
import 'package:coding_interview_flutter_app/src/domain/user/model/user.dart';

const _announcementId = 'id';
const _announcementTitle = 'title';
const _announcementDescription = 'description';
const _announcementCustomer = 'customer';
const _announcementActivityArea = 'activityArea';

class Announcement {
  int id = -1;
  String title = '', description = '';
  late User customer;
  late ActivityArea activityArea;

  Announcement();

  Map<String, dynamic> toJson() {
    return {
      _announcementId: id,
      _announcementTitle: title,
      _announcementDescription: description,
    };
  }

  /// Factory From Json function
  factory Announcement.fromJson(Map<String, dynamic> json) {
    Announcement announcement = Announcement();

    announcement.id = (json[_announcementId] != null &&
            int.tryParse(json[_announcementId].toString()) != null)
        ? json[_announcementId]
        : 0;

    announcement.title =
        (json[_announcementTitle] != null) ? json[_announcementTitle] : '';

    announcement.description = (json[_announcementDescription] != null)
        ? json[_announcementDescription]
        : '';

    try {
      announcement.customer = User.fromJson(json[_announcementCustomer]);
    } catch (err) {
      rethrow;
    }

    try {
      announcement.activityArea =
          ActivityArea.fromJson(json[_announcementActivityArea]);
    } catch (err) {
      rethrow;
    }

    if (announcement.id == -1 || announcement.id == 0) {
      throw ('Could not parse Announcement');
    }

    return announcement;
  }
}

class DtoAnnouncement {
  late String title, description, activityAreaId;
}

class DtoActionOnAnnouncement {
  late String comment, announcementId;
}
