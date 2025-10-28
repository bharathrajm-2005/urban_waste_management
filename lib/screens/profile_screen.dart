import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  // DUMMY DATA: Replace with user's profile image
                  backgroundImage: NetworkImage('https://placehold.co/100x100/green/white?text=U'),
                ),
                SizedBox(height: 12),
                Text('User Name', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text('user.email@example.com', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Divider(),
          _buildProfileOption(context, icon: Icons.person_outline_rounded, title: 'Edit Profile'),
          _buildProfileOption(context, icon: Icons.language_rounded, title: 'Language'),
          SwitchListTile(
            title: const Text('Notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
              // TODO: Add logic to enable/disable notifications
            },
            secondary: const Icon(Icons.notifications_outlined),
            activeThumbColor: Colors.green,
          ),
          const Divider(),
          _buildProfileOption(context, icon: Icons.help_outline_rounded, title: 'Help & Support'),
          _buildProfileOption(context, icon: Icons.logout_rounded, title: 'Logout', color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, {required IconData icon, required String title, Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.grey[600]),
      title: Text(title, style: TextStyle(color: color ?? Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {
        // TODO: Implement navigation or action for each option
      },
    );
  }
}
