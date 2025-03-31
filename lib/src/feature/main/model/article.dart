// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Article {
  String title;
  String content;

  Article({required this.title, required this.content});

  Article copyWith({String? title, String? content}) {
    return Article(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'content': content};
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Article(title: $title, content: $content)';

  @override
  bool operator ==(covariant Article other) {
    if (identical(this, other)) return true;

    return other.title == title && other.content == content;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode;
}

class DiaryEntry {
  String category;
  List<Article> articles;

  DiaryEntry({required this.category, required this.articles});

  DiaryEntry copyWith({String? category, List<Article>? articles}) {
    return DiaryEntry(
      category: category ?? this.category,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'category': category, 'articles': articles};
  }

  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      category: map['category'] as String,
      articles: List<Article>.from(
        (map['articles'] as List<dynamic>).map<Article>(
          (x) => Article.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiaryEntry.fromJson(String source) =>
      DiaryEntry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DiaryEntry(category: $category, articles: $articles)';

  @override
  bool operator ==(covariant DiaryEntry other) {
    if (identical(this, other)) return true;

    return other.category == category && other.articles == articles;
  }

  @override
  int get hashCode => category.hashCode ^ articles.hashCode;
}
