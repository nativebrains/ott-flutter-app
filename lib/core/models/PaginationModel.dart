class PaginationModel {
  final LinksModel links;
  final MetaModel meta;

  PaginationModel({
    required this.links,
    required this.meta,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      links: LinksModel.fromJson(json['links']),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}

class LinksModel {
  final String? self;
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  LinksModel({
    this.self,
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      self: json['self'],
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}

class MetaModel {
  final int currentPage;
  final int from;
  final int lastPage;
  final String path;
  final int perPage;
  final int to;
  final int total;

  MetaModel({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }
}

int? extractPageNumberForPagination(String url) {
  var uri = Uri.parse(url);
  return int.tryParse(uri.queryParameters['page'] ?? '');
}
