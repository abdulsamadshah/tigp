class AutoGenerate {
  AutoGenerate({
    required this.data,
  });

  late final List<subscriptionData> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => subscriptionData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class subscriptionData {
  subscriptionData({
    required this.id,
    required this.amount,
  });

  late final String id;
  late final String amount;

  subscriptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['amount'] = amount;
    return _data;
  }
}
