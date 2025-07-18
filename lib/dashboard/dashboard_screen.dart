import 'package:flutter/material.dart';
import 'widgets/course_card.dart';
import 'widgets/playlist_card.dart';
import 'widgets/badge_card.dart';
import '../services/learning_service.dart';
import '../models/course_model.dart';
import '../models/playlist_model.dart';
import '../models/badge_model.dart' as model;
import '../models/quiz_model.dart';
import 'widgets/user_profile_section.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final LearningService _learningService = LearningService();

  bool _isLoading = true;
  List<Course> _enrolledCourses = [];
  List<Course> _watchLaterCourses = [];
  List<Playlist> _playlists = [];
  List<Course> _downloadedCourses = [];
  List<Course> _historyCourses = [];
  List<Quiz> _quizzes = [];
  List<model.Badge> _badges = [];
  Map<String, dynamic> _progressStats = {};
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    final enrolled = await _learningService.getEnrolledCourses();
    final watchLater = await _learningService.getWatchLaterCourses();
    final playlists = await _learningService.getPlaylists();
    final downloads = await _learningService.getDownloadedCourses();
    final history = await _learningService.getCourseHistory();
    final quizzes = await _learningService.getQuizzes();
    final badges = await _learningService.getBadges();
    final stats = await _learningService.getProgressStats();
    final notifications = await _learningService.getNotifications();
    setState(() {
      _enrolledCourses = enrolled;
      _watchLaterCourses = watchLater;
      _playlists = playlists;
      _downloadedCourses = downloads;
      _historyCourses = history;
      _quizzes = quizzes;
      _badges = badges;
      _progressStats = stats;
      _notifications = notifications;
      _isLoading = false;
    });
  }

  Widget _sectionTitle(String title, {IconData? icon, VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.red, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (onSeeAll != null)
          TextButton(onPressed: onSeeAll, child: const Text('See all')),
      ],
    );
  }

  Widget _horizontalList<T>({required List<T> items, required Widget Function(T) itemBuilder, double height = 220, String emptyText = 'No items'}) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(child: Text(emptyText)),
      );
    }
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, i) => itemBuilder(items[i]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Learner Dashboard',
          style: TextStyle(
            color: Color(0xFF013A57),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF013A57)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => ListView(
                  padding: const EdgeInsets.all(16),
                  children: _notifications.isEmpty
                      ? [const Text('No notifications')]
                      : _notifications.map((n) => ListTile(
                          leading: Icon(
                            n['type'] == 'course'
                                ? Icons.play_circle_fill
                                : n['type'] == 'quiz'
                                    ? Icons.quiz
                                    : Icons.emoji_events,
                            color: n['isRead'] ? Colors.grey : Colors.red,
                          ),
                          title: Text(n['title']),
                          subtitle: Text(n['message']),
                          trailing: Text(
                            (n['timestamp'] as DateTime).toLocal().toString().substring(0, 16),
                            style: const TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ))
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF013A57)))
          : RefreshIndicator(
              onRefresh: _loadDashboardData,
              color: const Color(0xFF013A57),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Profile Section
                    UserProfileSection(
                      user: null, // TODO: Pass real user data here
                    ),
                    const SizedBox(height: 24),
                    // Progress Tracker
                    _sectionTitle('Progress Tracker', icon: Icons.show_chart),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Courses: ${_progressStats['completedCourses'] ?? 0}/${_progressStats['totalCourses'] ?? 0} completed'),
                            const SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: (_progressStats['averageProgress'] ?? 0) / 100.0,
                              minHeight: 6,
                              backgroundColor: Colors.grey[200],
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                            const SizedBox(height: 8),
                            Text('Quizzes Passed: ${_progressStats['passedQuizzes'] ?? 0}/${_progressStats['totalQuizzes'] ?? 0}'),
                            const SizedBox(height: 4),
                            Text('Badges: ${_progressStats['unlockedBadges'] ?? 0}/${_progressStats['totalBadges'] ?? 0}'),
                            const SizedBox(height: 4),
                            Text('Current Streak: ${_progressStats['currentStreak'] ?? 0} days'),
                            const SizedBox(height: 4),
                            Text('Total Watch Time: ${(_progressStats['totalWatchTime'] as Duration?)?.inHours ?? 0}h'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Courses Enrolled
                    _sectionTitle('Courses Enrolled', icon: Icons.play_circle_fill),
                    _horizontalList<Course>(
                      items: _enrolledCourses,
                      itemBuilder: (course) => CourseCard(course: course),
                      height: 260,
                      emptyText: 'No enrolled courses',
                    ),
                    const SizedBox(height: 24),
                    // Watch Later
                    _sectionTitle('Watch Later', icon: Icons.watch_later),
                    _horizontalList<Course>(
                      items: _watchLaterCourses,
                      itemBuilder: (course) => CourseCard(course: course),
                      height: 260,
                      emptyText: 'No courses in watch later',
                    ),
                    const SizedBox(height: 24),
                    // Playlists
                    _sectionTitle('Playlists', icon: Icons.playlist_play),
                    _horizontalList<Playlist>(
                      items: _playlists,
                      itemBuilder: (playlist) => PlaylistCard(playlist: playlist),
                      height: 180,
                      emptyText: 'No playlists',
                    ),
                    const SizedBox(height: 24),
                    // Downloads
                    _sectionTitle('Downloads', icon: Icons.download),
                    _horizontalList<Course>(
                      items: _downloadedCourses,
                      itemBuilder: (course) => CourseCard(course: course),
                      height: 260,
                      emptyText: 'No downloads',
                    ),
                    const SizedBox(height: 24),
                    // History
                    _sectionTitle('History', icon: Icons.history),
                    _horizontalList<Course>(
                      items: _historyCourses,
                      itemBuilder: (course) => CourseCard(course: course),
                      height: 260,
                      emptyText: 'No history',
                    ),
                    const SizedBox(height: 24),
                    // Tests & Quizzes
                    _sectionTitle('Tests & Quizzes', icon: Icons.quiz),
                    _horizontalList<Quiz>(
                      items: _quizzes,
                      itemBuilder: (quiz) => Card(
                        margin: const EdgeInsets.only(right: 16),
                        child: Container(
                          width: 220,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(quiz.statusIcon, color: quiz.statusColor),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      quiz.title,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(quiz.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 8),
                              Text('Questions: ${quiz.questionCount}'),
                              Text('Due: ${quiz.dueDate.toLocal().toString().substring(0, 10)}'),
                              const SizedBox(height: 8),
                              Text('Status: ${quiz.statusText}', style: TextStyle(color: quiz.statusColor)),
                              if (quiz.score != null) Text('Score: ${quiz.scoreText}'),
                            ],
                          ),
                        ),
                      ),
                      height: 180,
                      emptyText: 'No quizzes',
                    ),
                    const SizedBox(height: 24),
                    // Badges Earned
                    _sectionTitle('Badges Earned', icon: Icons.emoji_events),
                    _horizontalList<model.Badge>(
                      items: _badges,
                      itemBuilder: (badge) => BadgeCard(badge: badge),
                      height: 160,
                      emptyText: 'No badges',
                    ),
                  ],
                ),
              ),
            ),
    );
  }
} 