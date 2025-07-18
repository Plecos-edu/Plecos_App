import 'package:flutter/material.dart';
import 'package:pleocs/models/user_model.dart';

class UserProfileSection extends StatelessWidget {
  final User? user;

  const UserProfileSection({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final displayName = user?.name ?? 'User';
    final role = user?.role ?? 'Member';
    final isOnline = user?.isOnline ?? false;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: user?.avatarUrl.isNotEmpty == true
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          user!.avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF013A57),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isOnline ? const Color(0xFF10B981) : const Color(0xFF64748B),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isOnline ? 'Online' : 'Offline',
                          style: TextStyle(
                            fontSize: 12,
                            color: isOnline ? const Color(0xFF10B981) : const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Settings Button
              IconButton(
                onPressed: () {
                  // TODO: Navigate to profile settings
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile settings coming soon!')),
                  );
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Bio/About
          if (user?.bio != null && user!.bio.isNotEmpty) ...[
            const Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(user!.bio),
            const SizedBox(height: 8),
          ],
          // Qualifications
          if (user?.qualifications != null && user!.qualifications.isNotEmpty) ...[
            const Text('Qualifications', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: user!.qualifications.map((q) => Chip(label: Text(q))).toList(),
            ),
            const SizedBox(height: 8),
          ],
          // Education
          if (user?.education != null && user!.education.isNotEmpty) ...[
            const Text('Education', style: TextStyle(fontWeight: FontWeight.bold)),
            ...user!.education.map((e) => Text(e)).toList(),
            const SizedBox(height: 8),
          ],
          // Resume/Transcript
          if (user?.resumeUrl != null && user!.resumeUrl.isNotEmpty) ...[
            const Text('Resume/Transcript', style: TextStyle(fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                // TODO: Open resume URL
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening resume...')),
                );
              },
              child: Text(
                user!.resumeUrl,
                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 8),
          ],
          // Subject Areas
          if (user?.subjectAreas != null && user!.subjectAreas.isNotEmpty) ...[
            const Text('Subject Areas', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: user!.subjectAreas.map((s) => Chip(label: Text(s))).toList(),
            ),
            const SizedBox(height: 8),
          ],
          // Skill Levels
          if (user?.skillLevels != null && user!.skillLevels.isNotEmpty) ...[
            const Text('Skill Levels', style: TextStyle(fontWeight: FontWeight.bold)),
            ...user!.skillLevels.entries.map((entry) => Text('${entry.key}: ${entry.value}')).toList(),
            const SizedBox(height: 8),
          ],
          // Badges (IDs only, for full badge info use dashboard badges section)
          if (user?.badgeIds != null && user!.badgeIds.isNotEmpty) ...[
            const Text('Badges', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: user!.badgeIds.map((b) => Chip(label: Text(b))).toList(),
            ),
          ],
        ],
      ),
    );
  }
} 