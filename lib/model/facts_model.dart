class Facts {
  late String facts;
  Facts({required this.facts});

  Facts.fromJson(Map<String, dynamic> json) {
    facts = json['fact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fact'] = facts;
    return data;
  }
}
