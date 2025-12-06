import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  void _editDisplayName() {
    final nameController = TextEditingController(text: user?.displayName ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Display Name'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: "Enter new name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await user?.updateDisplayName(nameController.text.trim());
              await user?.reload();
              setState(() {
                user = FirebaseAuth.instance.currentUser;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Display name updated')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: user == null
          ? const Center(child: Text('No user found'))
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              user?.displayName ?? "No Name",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              user?.email ?? "No Email",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const Divider(height: 30),

          _buildProfileOption(
            icon: Icons.shopping_bag,
            title: 'My Orders',
            onTap: () {
              // Navigate to orders screen
            },
          ),
          _buildProfileOption(
            icon: Icons.location_on,
            title: 'Saved Addresses',
            onTap: () {
              // Navigate to address screen
            },
          ),
          _buildProfileOption(
            icon: Icons.payment,
            title: 'Payment Methods',
            onTap: () {
              // Navigate to payment methods screen
            },
          ),
          _buildProfileOption(
            icon: Icons.support_agent,
            title: 'Customer Support',
            onTap: () {
              // Navigate to support screen
            },
          ),
          _buildProfileOption(
            icon: Icons.settings,
            title: 'App Settings',
            onTap: () {
              // Navigate to settings screen
            },
          ),
          _buildProfileOption(
            icon: Icons.edit,
            title: 'Edit Name',
            onTap: _editDisplayName,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
