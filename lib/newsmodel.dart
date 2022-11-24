class AutoGenerate {
  AutoGenerate({
    required this.data,
  });
  late final List<Datas> data;

  AutoGenerate.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Datas.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Datas {
  Datas({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.image,
  });
  late final String id;
  late final String name;
  late final String date;
  late final String description;
  late final String image;

  Datas.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    date = json['date'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['date'] = date;
    _data['description'] = description;
    _data['image'] = image;
    return _data;
  }
}