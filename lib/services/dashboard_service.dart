import 'package:pleocs/models/user_model.dart';
import 'package:pleocs/models/activity_model.dart';

class DashboardService {
  static final DashboardService _instance = DashboardService._internal();
  factory DashboardService() => _instance;
  DashboardService._internal();

  // Mock user data
  User get currentUser => User(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@pleocs.com',
    role: 'Senior Developer',
    isOnline: true,
    lastSeen: DateTime.now(),
  );

  // Mock dashboard stats
  Map<String, int> get dashboardStats => {
    'totalProjects': 12,
    'activeTasks': 8,
    'teamMembers': 24,
    'completedTasks': 156,
  };

  // Mock recent activities
  List<Activity> get recentActivities => [
    Activity(
      id: '1',
      title: 'New project "E-commerce App" created',
      description: 'Created a new project for the e-commerce application',
      type: ActivityType.projectCreated,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      userId: '1',
      userName: 'John Doe',
    ),
    Activity(
      id: '2',
      title: 'Task "Design Review" completed',
      description: 'Completed the design review for the mobile app',
      type: ActivityType.taskCompleted,
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      userId: '2',
      userName: 'Sarah Wilson',
    ),
    Activity(
      id: '3',
      title: 'Team member Sarah joined',
      description: 'Sarah Wilson joined the development team',
      type: ActivityType.teamMemberJoined,
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      userId: '2',
      userName: 'Sarah Wilson',
    ),
    Activity(
      id: '4',
      title: 'Project "Mobile App" updated',
      description: 'Updated the mobile app project with new features',
      type: ActivityType.projectUpdated,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      userId: '3',
      userName: 'Mike Johnson',
    ),
    Activity(
      id: '5',
      title: 'Meeting scheduled for tomorrow',
      description: 'Scheduled a team meeting for tomorrow at 10 AM',
      type: ActivityType.meetingScheduled,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      userId: '1',
      userName: 'John Doe',
    ),
  ];

  // Mock quick actions
  List<Map<String, dynamic>> get quickActions => [
    {
      'title': 'Create Project',
      'icon': 'add_circle_outline',
      'color': 0xFF3B82F6,
      'action': 'create_project',
    },
    {
      'title': 'Add Task',
      'icon': 'task_alt',
      'color': 0xFF10B981,
      'action': 'add_task',
    },
    {
      'title': 'Invite Team',
      'icon': 'person_add_outlined',
      'color': 0xFFF59E0B,
      'action': 'invite_team',
    },
    {
      'title': 'View Reports',
      'icon': 'analytics_outlined',
      'color': 0xFF8B5CF6,
      'action': 'view_reports',
    },
  ];

  // Method to update user status
  void updateUserStatus(bool isOnline) {
    // TODO: Implement API call to update user status
  }

  // Method to get user profile
  Future<User> getUserProfile() async {
    // TODO: Implement API call to get user profile
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
    return currentUser;
  }

  // Method to get dashboard stats
  Future<Map<String, int>> getDashboardStats() async {
    // TODO: Implement API call to get dashboard stats
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate API delay
    return dashboardStats;
  }

  // Method to get recent activities
  Future<List<Activity>> getRecentActivities() async {
    // TODO: Implement API call to get recent activities
    await Future.delayed(const Duration(milliseconds: 400)); // Simulate API delay
    return recentActivities;
  }

  // Method to perform quick action
  Future<void> performQuickAction(String action) async {
    // TODO: Implement quick action logic
    await Future.delayed(const Duration(milliseconds: 200)); // Simulate API delay
    print('Performing action: $action');
  }
} 