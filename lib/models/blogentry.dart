
import 'package:pocketbase/pocketbase.dart';

class BlogEntry {
  //String uuid = const Uuid().v1();
  String id;
  String title;
  String content;
  String creationDate;
  bool liked;

  BlogEntry(
      { required this.id,
        required this.title,
      required this.content,
      required this.creationDate,
      required this.liked});

  factory BlogEntry.fromJson(Map<String, dynamic> json) {
    // print( json ); // for debugging
    return switch (json) {
      {
        '\$id': String id,
        'title': String title,
        'content': String content,
      } => 
        BlogEntry(
          id: id,
          title: title,
          content: content,
          creationDate: DateTime.now().toString(),
          liked: false,
        ),
      _ => throw const FormatException('Failed to load blog entry.'),
    };
  }

  factory BlogEntry.fromRecord(RecordModel record) {
    return BlogEntry(id: record.id, title: record.data['title'], content: record.data['content'], creationDate: record.created, liked: record.data['liked']);
  }
}
