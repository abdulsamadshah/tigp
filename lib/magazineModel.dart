class AutoGenerate {
  AutoGenerate({
    required this.data,
  });

  late final List<videoData> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => videoData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class videoData {
  videoData({
    required this.id,
    required this.name,
    required this.date,
    required this.file,
    required this.image,
  });

  late final String id;
  late final String name;
  late final String date;
  late final String file;
  late final String image;

  videoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    file = json['file'];
    image = json['image'];
  }

  get type => null;

  get youtubeid => null;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['date'] = date;
    _data['file'] = file;
    _data['image'] = image;
    return _data;
  }
}
