import 'package:flutter/material.dart';

class RiderProfileScreen extends StatelessWidget {
  const RiderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Picture and Change Button
              ProfilePictureSection(),

              SizedBox(height: 20),

              // Personal Information Section
              PersonalInfoSection(),

              SizedBox(height: 20),

              // Account Details Section
              AccountDetailsSection(),

              SizedBox(height: 20),

              // Documents Section
              DocumentsSection(),

              SizedBox(height: 20),

              // Settings Section
              SettingsSection(),

              SizedBox(height: 30),

              // Logout Button
              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// Profile Picture Widget
class ProfilePictureSection extends StatelessWidget {
  const ProfilePictureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage:
                NetworkImage('https://www.example.com/profile-picture.jpg'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Functionality to change profile picture
            },
            child: const Text('Change Picture'),
          ),
        ],
      ),
    );
  }
}

// Personal Information Widget
class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('John Doe'),
          subtitle: Text('Name'),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('john.doe@example.com'),
          subtitle: Text('Email'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('+123 456 7890'),
          subtitle: Text('Phone'),
        ),
      ],
    );
  }
}

// Account Details Widget
class AccountDetailsSection extends StatelessWidget {
  const AccountDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('Active'),
          subtitle: Text('Account Status'),
        ),
        ListTile(
          leading: Icon(Icons.directions_car),
          title: Text('Toyota Prius'),
          subtitle: Text('Vehicle'),
        ),
      ],
    );
  }
}

// Documents Section Widget
class DocumentsSection extends StatelessWidget {
  const DocumentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Documents',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.file_copy),
          title: const Text('Driver’s License'),
          subtitle: const Text('Uploaded'),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Functionality to update document
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.file_copy),
          title: const Text('Vehicle Insurance'),
          subtitle: const Text('Uploaded'),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Functionality to update document
            },
          ),
        ),
      ],
    );
  }
}

// Settings Section Widget
class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SwitchListTile(
          title: const Text('Availability'),
          subtitle: const Text('Toggle availability status'),
          value: true,
          onChanged: (val) {
            // Functionality to update availability
          },
        ),
        SwitchListTile(
          title: const Text('Notifications'),
          subtitle: const Text('Enable or disable notifications'),
          value: true,
          onChanged: (val) {
            // Functionality to update notification preferences
          },
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Language'),
          subtitle: const Text('English'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Functionality to change language
          },
        ),
      ],
    );
  }
}

// Logout Button Widget
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Functionality to log out
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 50), // Full width button
      ),
      child: const Text('Logout'),
    );
  }
}
