import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/user_location.dart';

class LocationInfoBottomSheet extends StatelessWidget {
  final UserLocation location;

  const LocationInfoBottomSheet({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            // Title
            const Text(
              'Current Location Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Location Info Cards
            _buildInfoCard(
              icon: Icons.location_on,
              title: 'Coordinates',
              subtitle: '${location.latitude.toStringAsFixed(6)}, ${location.longitude.toStringAsFixed(6)}',
              onTap: () => _copyToClipboard(
                context,
                '${location.latitude}, ${location.longitude}',
                'Coordinates copied to clipboard',
              ),
            ),
            
            if (location.accuracy != null)
              _buildInfoCard(
                icon: Icons.gps_fixed,
                title: 'Accuracy',
                subtitle: '±${location.accuracy!.toStringAsFixed(1)} meters',
              ),
            
            if (location.altitude != null)
              _buildInfoCard(
                icon: Icons.height,
                title: 'Altitude',
                subtitle: '${location.altitude!.toStringAsFixed(1)} meters',
              ),
            
            if (location.speed != null && location.speed! > 0)
              _buildInfoCard(
                icon: Icons.speed,
                title: 'Speed',
                subtitle: '${(location.speed! * 3.6).toStringAsFixed(1)} km/h',
              ),
            
            if (location.heading != null)
              _buildInfoCard(
                icon: Icons.navigation,
                title: 'Heading',
                subtitle: '${location.heading!.toStringAsFixed(1)}°',
              ),
            
            if (location.timestamp != null)
              _buildInfoCard(
                icon: Icons.access_time,
                title: 'Last Updated',
                subtitle: _formatTimestamp(location.timestamp!),
              ),
            
            const SizedBox(height: 16),
            
            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Close'),
              ),
            ),
            
            // Add safe area padding
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.redAccent.withOpacity(0.2),
          child: Icon(icon, color: AppColors.red),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: onTap != null 
          ? const Icon(Icons.copy, size: 16, color: AppColors.gray)
          : null,
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}