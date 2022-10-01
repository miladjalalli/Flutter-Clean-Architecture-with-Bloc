class GetNewsResponseDto {
  String category;
  List<News> data;
  bool success;

  GetNewsResponseDto({this.category, this.data, this.success});

  GetNewsResponseDto.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['data'] != null) {
      data = <News>[];
      json['data'].forEach((v) {
        data.add(new News.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class News {
  String author;
  String content;
  String date;
  String id;
  String imageUrl;
  String readMoreUrl;
  String time;
  String title;
  String url;

  News(
      {this.author,
        this.content,
        this.date,
        this.id,
        this.imageUrl,
        this.readMoreUrl,
        this.time,
        this.title,
        this.url});

  News.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
    date = json['date'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    readMoreUrl = json['readMoreUrl'];
    time = json['time'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['content'] = this.content;
    data['date'] = this.date;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['readMoreUrl'] = this.readMoreUrl;
    data['time'] = this.time;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
