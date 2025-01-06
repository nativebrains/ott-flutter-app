import '../../../constants/constants.dart';

class ActorModel {
  String? actorId;
  String? actorName;
  String? actorImage;

  ActorModel({
    this.actorId,
    this.actorName,
    this.actorImage,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
      actorId: json[Constants.ACTOR_ID],
      actorName: json[Constants.ACTOR_NAME],
      actorImage: json[Constants.ACTOR_IMAGE],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.ACTOR_ID: actorId,
      Constants.ACTOR_NAME: actorName,
      Constants.ACTOR_IMAGE: actorImage,
    };
  }
}
