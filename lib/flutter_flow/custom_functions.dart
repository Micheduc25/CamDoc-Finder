import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import '../../auth/auth_util.dart';

DocumentReference getChatRecord(
  ChatsRecord newChat,
  ChatsRecord chatRecord,
) {
  if (chatRecord != null) return chatRecord.reference;
  return newChat.reference;
}
