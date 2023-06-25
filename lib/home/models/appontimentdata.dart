class AppointmentModel {
  late String namekhadma;
  late String data;
  late String total;
  late String createdAt;
  late String id;
  late bool delete;

  AppointmentModel({
    required this.namekhadma,
    required this.total,
    required this.data,
    required this.createdAt,
    required this.id,
    required this.delete,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {

    namekhadma = json['namekhadma'];
    total = json['total'];
    data = json['data'];
    createdAt = json['createdAt'];
    id = json['id'];
    delete = json['delete'];
  }

  Map<String, dynamic> toMap() {
    return {
      'namekhadma': namekhadma,
      'total': total,
      'data': data,
      'createdAt': createdAt,
      'id': id,
      'delete': delete,
    };
  }
}
