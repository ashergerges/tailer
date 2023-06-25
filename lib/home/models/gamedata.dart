class GameModel {
  late String nameGame;
  late String ageSuitable;
  late String description;
  late String requirement;
  late String gameIma;
  late String notes;
  late String createdAt;
  late String id;
  late String number3;
  late String number4;
  late String email;
  late bool delete;

  GameModel({
    required this.nameGame,
    required this.ageSuitable,
    required this.description,
    required this.requirement,
    required this.gameIma,
    required this.notes,
    required this.createdAt,
    required this.id,
    required this.number3,
    required this.number4,
    required this.email,
    required this.delete,

  });

  GameModel.fromJson(Map<String, dynamic> json) {

    nameGame = json['nameGame'];
    ageSuitable = json['ageSuitable'];
    description = json['description'];
    requirement = json['requirement'];
    gameIma = json['gameIma'];
    notes = json['notes'];
    createdAt = json['createdAt'];
    id = json['id'];
    number3 = json['number3'];
    number4 = json['number4'];
    email = json['email'];
    delete = json['delete'];

}
  Map<String, dynamic> toMap() {
    return {
      'nameGame': nameGame,
      'ageSuitable': ageSuitable,
      'description': description,
      'requirement': requirement,
      'gameIma': gameIma,
      'notes': notes,
      'createdAt': createdAt,
      'id': id,
      'number3': number3,
      'number4': number4,
      'email': email,
      'delete': delete,
    };
  }
}
