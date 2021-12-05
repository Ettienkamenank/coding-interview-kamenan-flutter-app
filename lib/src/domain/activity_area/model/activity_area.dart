const _activityAreaId = 'id';
const _activityAreaTitle = 'title';
const _activityAreaDescription = 'description';

class ActivityArea {
  int id = -1;
  String title = '', description = '';

  ActivityArea();

  Map<String, dynamic> toJson() {
    return {
      _activityAreaId: id,
      _activityAreaTitle: title,
      _activityAreaDescription: description,
    };
  }

  /// Factory From Json function
  factory ActivityArea.fromJson(Map<String, dynamic> json) {
    ActivityArea activityArea = ActivityArea();

    activityArea.id = (json[_activityAreaId] != null &&
            int.tryParse(json[_activityAreaId].toString()) != null)
        ? json[_activityAreaId]
        : 0;

    activityArea.title =
        (json[_activityAreaTitle] != null) ? json[_activityAreaTitle] : '';

    activityArea.description = (json[_activityAreaDescription] != null)
        ? json[_activityAreaDescription]
        : '';

    if (activityArea.id == -1 || activityArea.id == 0) {
      throw ('Could not parse ActivityArea');
    }

    return activityArea;
  }
}
