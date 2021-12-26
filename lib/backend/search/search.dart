import 'package:cam_doc_finder/backend/schema/chat_messages_record.dart';
import 'package:cam_doc_finder/backend/schema/users_record.dart';
import 'package:cam_doc_finder/flutter_flow/chat/index.dart';

class SearchItems {
  static List<LostDocumentsRecord> documentsSearch(
      {String query = "", List<LostDocumentsRecord> collection}) {
    if (query.isEmpty) return collection;

    List<LostDocumentsRecord> temp = [];
    for (int n = 0; n < (collection.length); n++) {
      if (searchString(query, collection[n].title) ||
          searchString(query, collection[n].description)) {
        temp.add(collection[n]);
      }
    }

    return temp;
  }

  static List<UsersRecord> userSearch(
      {String query = "", List<UsersRecord> collection}) {
    if (query.isEmpty) return collection;

    List<UsersRecord> temp = [];
    for (int n = 0; n < (collection.length); n++) {
      if (searchString(query, collection[n].displayName) ||
          searchString(query, collection[n].phoneNumber)) {
        temp.add(collection[n]);
      }
    }
    return temp;
  }

  static Future<List<ChatsRecord>> chatsSearch(
      {String query = "", List<ChatsRecord> collection}) async {
    if (query.isEmpty) return collection;

    List<ChatsRecord> temp = [];
    for (int n = 0; n < (collection.length); n++) {
      final userA = await UsersRecord.getDocument(collection[n].userA).first;
      final userB = await UsersRecord.getDocument(collection[n].userB).first;

      final otherUser = currentUserUid != userA.uid ? userA : userB;

      // final allChatMessages = await queryChatMessagesRecord(queryBuilder: (query){
      //   return query.where('chat', isEqualTo:collection[n].reference );
      // }).first;

      if (searchString(query, otherUser.displayName)) {
        temp.add(collection[n]);
      }
    }
    return temp;
  }

  static List<ChatMessagesRecord> messageSearch(
      {String query = "", List<ChatMessagesRecord> collection}) {
    if (query.isEmpty) return collection;

    List<ChatMessagesRecord> temp = [];
    for (int n = 0; n < (collection.length); n++) {
      if (searchString(query, collection[n].text)) {
        temp.add(collection[n]);
      }
    }
    return temp;
  }

  static bool searchString(String string1, String lstring) {
    string1 = string1.toLowerCase();
    lstring = lstring.toLowerCase();
    for (int n = 0; n < (lstring.length); n++) {
      if (lstring[n] == string1[0]) {
        if (n + (string1.length) - 1 < lstring.length) {
          print(string1);
          print(lstring.substring(n, n + (string1.length)));
          if (string1 == lstring.substring(n, n + (string1.length))) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
