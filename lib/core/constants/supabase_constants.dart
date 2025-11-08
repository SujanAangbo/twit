import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConstants {
  SupabaseConstants._();

  static String projectUrl = dotenv.env['NEXT_PUBLIC_SUPABASE_URL']!;
  static String apiKey = dotenv.env['NEXT_PUBLIC_SUPABASE_ANON_KEY']!;

  static String serverClientId = dotenv.env['SERVER_CLIENT_ID']!;

  // tables
  static String usersTable = 'users';
  static String twitTable = 'twits';
  static String followsTable = 'follows';
  static String notificationTable = 'notifications';
  static String messageTable = 'messages';
  static String roomTable = 'rooms';

  // buckets
  static String storagePath = '$projectUrl/storage/v1/object/public/';
  static String twitImageBucket = 'twit_images';
}
