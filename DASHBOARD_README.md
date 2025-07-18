# PLECOS Dashboard System

A comprehensive dashboard system for the PLECOS Flutter application with modern UI design and dynamic functionality.

## Features

### 🎯 User Dashboard
- **User Profile Section**: Displays user information with avatar, name, role, and online status
- **Welcome Message**: Personalized greeting with user's first name
- **Statistics Cards**: Real-time metrics for projects, tasks, team members, and completed items
- **Quick Actions**: Easy access to common tasks like creating projects, adding tasks, inviting team members, and viewing reports
- **Recent Activities**: Timeline of recent user activities with times

tamps and icons
- **Bottom Navigation**: Navigation bar with Dashboard, Projects, Tasks, Team, and Profile sections

### 🎨 Design Features
- **Modern UI**: Clean, professional design with consistent color scheme
- **Gradient Cards**: Beautiful gradient backgrounds for statistics cards
- **Responsive Layout**: Adapts to different screen sizes
- **Loading States**: Smooth loading indicators and error handling
- **Pull-to-Refresh**: Refresh dashboard data by pulling down
- **Interactive Elements**: Hover effects and smooth animations

### 🔧 Technical Features
- **Service Layer**: Centralized data management with DashboardService
- **Model Classes**: Structured data models for User and Activity
- **Dynamic Data**: Real-time data loading and updates
- **Error Handling**: Graceful error handling with user-friendly messages
- **Modular Architecture**: Separated concerns with reusable widgets

## File Structure

```
lib/
├── dashboard/
│   ├── dashboard_screen.dart          # Main dashboard screen
│   └── widgets/
│       ├── dashboard_card.dart        # Statistics card widget
│       ├── user_profile_section.dart  # User profile widget
│       ├── quick_actions.dart         # Quick actions widget
│       └── recent_activities.dart     # Recent activities widget
├── models/
│   ├── user_model.dart               # User data model
│   └── activity_model.dart           # Activity data model
├── services/
│   └── dashboard_service.dart        # Dashboard data service
└── splash Screen/
    └── splash_screen.dart            # Updated splash screen
```

## Components

### DashboardScreen
The main dashboard screen that orchestrates all dashboard components and manages the overall layout.

### UserProfileSection
Displays user information including:
- User avatar (with fallback to icon)
- User name and role
- Online/offline status
- Edit profile button

### DashboardCard
Reusable statistics cards with:
- Gradient backgrounds
- Icons and values
- Trend indicators
- Customizable colors

### QuickActions
Interactive action buttons for:
- Create Project
- Add Task
- Invite Team
- View Reports

### RecentActivities
Timeline of recent activities showing:
- Activity type with appropriate icons
- Activity descriptions
- Relative timestamps
- Color-coded activity types

## Data Models

### User Model
```dart
class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String avatarUrl;
  final bool isOnline;
  final DateTime lastSeen;
}
```

### Activity Model
```dart
class Activity {
  final String id;
  final String title;
  final String description;
  final ActivityType type;
  final DateTime timestamp;
  final String userId;
  final String userName;
  final Map<String, dynamic>? metadata;
}
```

## Service Layer

### DashboardService
Singleton service that provides:
- Mock user data
- Dashboard statistics
- Recent activities
- Quick actions
- API simulation with delays

## Usage

The dashboard is automatically loaded after the splash screen animation completes. Users can:

1. **View Statistics**: See real-time project and task metrics
2. **Perform Actions**: Use quick action buttons for common tasks
3. **Monitor Activities**: Track recent team and project activities
4. **Navigate**: Use bottom navigation to access different sections
5. **Refresh**: Pull down to refresh dashboard data

## Customization

### Colors
The dashboard uses a consistent color scheme:
- Primary: `#013A57` (Dark Blue)
- Secondary: `#64748B` (Gray)
- Accent Colors: Various colors for different activity types

### Adding New Features
1. **New Statistics**: Add new DashboardCard widgets
2. **New Actions**: Extend the quickActions list in DashboardService
3. **New Activities**: Add new ActivityType enum values
4. **New Sections**: Create new widget components

## Future Enhancements

- [ ] Real API integration
- [ ] User authentication
- [ ] Push notifications
- [ ] Dark mode support
- [ ] Offline functionality
- [ ] Data persistence
- [ ] Advanced filtering
- [ ] Export functionality

## Dependencies

The dashboard system uses only Flutter's built-in packages:
- `flutter/material.dart` - UI components
- No external dependencies required

## Getting Started

1. Ensure Flutter is installed and configured
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application
4. The dashboard will load automatically after the splash screen

The dashboard system provides a solid foundation for a modern project management application with room for future enhancements and integrations. 