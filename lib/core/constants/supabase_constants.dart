class SupabaseConstants {
  SupabaseConstants._();

  static String projectUrl = 'https://evtjetcsrxhjgndjmcaa.supabase.co';
  static String apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV2dGpldGNzcnhoamduZGptY2FhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY3MzQ5NjgsImV4cCI6MjA3MjMxMDk2OH0.lYt8zTthugeYWgrHy0gAkEM4KZGjxOFq_o0TOl7g1MI';

  // tables
  static String usersTable = 'users';
  static String twitTable = 'twits';
  static String followsTable = 'follows';
  static String notificationTable = 'notifications';
  static String messageTable = 'messages';
  static String roomTable = 'rooms';

  // buckets
  static String storagePath =
      'https://evtjetcsrxhjgndjmcaa.supabase.co/storage/v1/object/public/';
  static String twitImageBucket = 'twit_images';
}
