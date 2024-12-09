class PropertiesResponse {
  PropertiesResponse({
      List<Property>? data,
      Links? links, 
      Meta? meta,}){
    _data = data;
    _links = links;
    _meta = meta;
}

  PropertiesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Property.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<Property>? _data;
  Links? _links;
  Meta? _meta;
PropertiesResponse copyWith({  List<Property>? data,
  Links? links,
  Meta? meta,
}) => PropertiesResponse(  data: data ?? _data,
  links: links ?? _links,
  meta: meta ?? _meta,
);
  List<Property>? get data => _data;
  Links? get links => _links;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map['links'] = _links?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }

}

class Meta {
  Meta({
      List<num>? currentPage, 
      num? from, 
      List<num>? lastPage, 
      String? path, 
      List<num>? perPage, 
      num? to, 
      List<num>? total,}){
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
}

  Meta.fromJson(dynamic json) {
    _currentPage = json['current_page'] != null ? json['current_page'].cast<num>() : [];
    _from = json['from'];
    _lastPage = json['last_page'] != null ? json['last_page'].cast<num>() : [];
    _path = json['path'];
    _perPage = json['per_page'] != null ? json['per_page'].cast<num>() : [];
    _to = json['to'];
    _total = json['total'] != null ? json['total'].cast<num>() : [];
  }
  List<num>? _currentPage;
  num? _from;
  List<num>? _lastPage;
  String? _path;
  List<num>? _perPage;
  num? _to;
  List<num>? _total;
Meta copyWith({  List<num>? currentPage,
  num? from,
  List<num>? lastPage,
  String? path,
  List<num>? perPage,
  num? to,
  List<num>? total,
}) => Meta(  currentPage: currentPage ?? _currentPage,
  from: from ?? _from,
  lastPage: lastPage ?? _lastPage,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  to: to ?? _to,
  total: total ?? _total,
);
  List<num>? get currentPage => _currentPage;
  num? get from => _from;
  List<num>? get lastPage => _lastPage;
  String? get path => _path;
  List<num>? get perPage => _perPage;
  num? get to => _to;
  List<num>? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class Links {
  Links({
      String? first, 
      String? last, 
      dynamic prev, 
      String? next,}){
    _first = first;
    _last = last;
    _prev = prev;
    _next = next;
}

  Links.fromJson(dynamic json) {
    _first = json['first'];
    _last = json['last'];
    _prev = json['prev'];
    _next = json['next'];
  }
  String? _first;
  String? _last;
  dynamic _prev;
  String? _next;
Links copyWith({  String? first,
  String? last,
  dynamic prev,
  String? next,
}) => Links(  first: first ?? _first,
  last: last ?? _last,
  prev: prev ?? _prev,
  next: next ?? _next,
);
  String? get first => _first;
  String? get last => _last;
  dynamic get prev => _prev;
  String? get next => _next;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first'] = _first;
    map['last'] = _last;
    map['prev'] = _prev;
    map['next'] = _next;
    return map;
  }

}

class Property {
  Property({
      num? id, 
      String? title, 
      String? description, 
      String? location, 
      num? rentPrice, 
      num? isAvailable, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _title = title;
    _description = description;
    _location = location;
    _rentPrice = rentPrice;
    _isAvailable = isAvailable;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Property.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _location = json['location'];
    _rentPrice = json['rent_price'];
    _isAvailable = json['is_available'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _title;
  String? _description;
  String? _location;
  num? _rentPrice;
  num? _isAvailable;
  String? _createdAt;
  String? _updatedAt;
Property copyWith({  num? id,
  String? title,
  String? description,
  String? location,
  num? rentPrice,
  num? isAvailable,
  String? createdAt,
  String? updatedAt,
}) => Property(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  location: location ?? _location,
  rentPrice: rentPrice ?? _rentPrice,
  isAvailable: isAvailable ?? _isAvailable,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get location => _location;
  num? get rentPrice => _rentPrice;
  num? get isAvailable => _isAvailable;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['location'] = _location;
    map['rent_price'] = _rentPrice;
    map['is_available'] = _isAvailable;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}