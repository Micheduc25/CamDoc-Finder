import 'package:intl/intl.dart';

import 'index.dart';

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class FFChatPreview extends StatelessWidget {
  const FFChatPreview({
    Key key,
    @required this.lastChatText,
    @required this.lastChatTime,
    @required this.seen,
    @required this.userName,
    @required this.userProfilePic,
    @required this.onTap,
    // Theme settings
    @required this.color,
    @required this.unreadColor,
    @required this.titleTextStyle,
    @required this.dateTextStyle,
    @required this.previewTextStyle,
    this.contentPadding = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  final String lastChatText;
  final DateTime lastChatTime;
  final bool seen;
  final String userName;
  final String userProfilePic;
  final Function() onTap;

  final Color color;
  final Color unreadColor;
  final TextStyle titleTextStyle;
  final TextStyle dateTextStyle;
  final TextStyle previewTextStyle;
  final EdgeInsetsGeometry contentPadding;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final name = userName.isNotEmpty ? userName : 'Friend';
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: borderRadius,
            child: ListTile(
              tileColor: color,
              contentPadding: contentPadding,
              leading: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 70),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 0.0, end: 8.0),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: seen ? Colors.transparent : unreadColor,
                        ),
                      ),
                    ),
                    AvatarContainer(
                      user: ChatUser(name: name, avatar: userProfilePic),
                      avatarMaxSize: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ],
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        name.maybeHandleOverflow(
                            maxChars: 22, replacement: "..."),
                        style: titleTextStyle,
                        overflow: TextOverflow.ellipsis),
                    Text(
                        formattedDate(lastChatTime, true).maybeHandleOverflow(
                            maxChars: 12, replacement: "..."),
                        style: dateTextStyle.copyWith(fontSize: 10),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              subtitle: Text(
                lastChatText,
                style: previewTextStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: previewTextStyle.color,
              ),
            ),
          ),
          const SizedBox(height: 2.0),
        ],
      ),
    );
  }
}

String formattedDate(DateTime dateTime, [bool isChatList = false]) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final day = DateTime(dateTime.year, dateTime.month, dateTime.day);
  if (dateTime.isAfter(now.subtract(const Duration(minutes: 30))) &&
      isChatList == false) {
    return timeago.format(dateTime);
  }
  if (today == day) {
    return DateFormat.Hm().format(dateTime);
  }
  if (yesterday == day) {
    return 'Yesterday';
  }
  if (isChatList) return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  return DateFormat.MMMMd().format(dateTime);
}
