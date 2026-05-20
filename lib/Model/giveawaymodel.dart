class GiveawayModelHeader {
  int? rescode;
  String? exception;
  List<GiveawayModel>? data;

  GiveawayModelHeader({
    required this.rescode,
    required this.exception,
    required this.data,
  });

  factory GiveawayModelHeader.fromjson(List<dynamic> jsons, int rescode) {
    var lists = jsons;
    // var lists = jsons as List;
    List<GiveawayModel> datalist =
        lists.map((e) => GiveawayModel.fromJson(e)).toList();

    return GiveawayModelHeader(
      rescode: rescode,
      exception: null,
      data: datalist,
    );
  }
  factory GiveawayModelHeader.exception(
    Map<String, dynamic> jsons,
    int rescode,
  ) {
    return GiveawayModelHeader(
      rescode: rescode,
      exception: jsons['status_message'],
      data: null,
    );
  }
  factory GiveawayModelHeader.issue(String jsons, int rescode) {
    return GiveawayModelHeader(rescode: rescode, exception: jsons, data: null);
  }
}

class GiveawayModel {
  int id;
  String title;
  String worth;
  String thumbnail;
  String image;
  String description;
  String instructions;
  String openGiveawayUrl;
  String publishedDate;
  String type;
  String platforms;
  String endDate;
  int users;
  String status;
  String gamerpowerUrl;

  GiveawayModel({
    required this.id,
    required this.title,
    required this.worth,
    required this.thumbnail,
    required this.image,
    required this.description,
    required this.instructions,
    required this.openGiveawayUrl,
    required this.publishedDate,
    required this.type,
    required this.platforms,
    required this.endDate,
    required this.users,
    required this.status,
    required this.gamerpowerUrl,
  });

  factory GiveawayModel.fromJson(Map<String, dynamic> json) {
    return GiveawayModel(
      id: json['id'],
      title: json['title'],
      worth: json['worth'],
      thumbnail: json['thumbnail'],
      image: json['image'],
      description: json['description'],
      instructions: json['instructions'],
      openGiveawayUrl: json['open_giveaway_url'],
      publishedDate: json['published_date'],
      type: json['type'],
      platforms: json['platforms'],
      endDate: json['end_date'],
      users: json['users'],
      status: json['status'],
      gamerpowerUrl: json['gamerpower_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'image': image,
      'description': description,
      'platforms': platforms,
      'end_date': endDate,
      'type': type,
      'worth': worth,
      'status': status,
      'users': users,
      'open_giveaway': openGiveawayUrl,
    };
  }
}
