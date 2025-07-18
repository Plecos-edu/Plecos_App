import 'package:flutter/material.dart';
import '../../models/badge_model.dart' as model;

class BadgeCard extends StatelessWidget {
  final model.Badge badge;
  final VoidCallback? onTap;

  const BadgeCard({
    Key? key,
    required this.badge,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: badge.isUnlocked ? Colors.white : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: badge.isUnlocked ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
          border: badge.isUnlocked ? null : Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: badge.isUnlocked ? badge.color.withOpacity(0.1) : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                badge.icon,
                size: 30,
                color: badge.isUnlocked ? badge.color : Colors.grey[500],
              ),
            ),
            const SizedBox(height: 8),
            // Badge name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                badge.name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: badge.isUnlocked ? Colors.black87 : Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            // Progress or unlocked status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badge.isUnlocked 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badge.progressText,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: badge.isUnlocked ? Colors.green : Colors.blue,
                ),
              ),
            ),
            if (!badge.isUnlocked) ...[
              const SizedBox(height: 4),
              // Progress bar
              Container(
                width: 80,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: badge.progressPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: badge.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 