import 'package:flutter/material.dart';

class SupportAndHelpScreen extends StatelessWidget {
  const SupportAndHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support & Help'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Help Topics Section
            HelpTopicsSection(),

            const SizedBox(height: 20),

            // Contact Support Section
            const ContactSupportSection(),

            const SizedBox(height: 20),

            // Report an Issue Section
            ReportIssueSection(),

            const SizedBox(height: 20),

            // Terms and Conditions / Policies
            const TermsAndConditionsSection(),
          ],
        ),
      ),
    );
  }
}

// Help Topics Widget
class HelpTopicsSection extends StatelessWidget {
  final List<Map<String, String>> faq = [
    {
      'question': 'How do I start my first delivery?',
      'answer': 'To start, accept an order and follow the instructions.'
    },
    {
      'question': 'What should I do if a customer is not available?',
      'answer': 'Contact the customer using the in-app chat.'
    },
    {
      'question': 'How can I track my earnings?',
      'answer':
          'You can track your earnings in the "Earnings" section on the main menu.'
    },
  ];

  HelpTopicsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Help Topics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...faq.map((faqItem) {
          return ExpansionTile(
            title: Text(faqItem['question']!),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(faqItem['answer']!),
              )
            ],
          );
        }),
      ],
    );
  }
}

// Contact Support Section Widget
class ContactSupportSection extends StatelessWidget {
  const ContactSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Support',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            // Functionality to contact support (e.g., email or chat)
          },
          icon: const Icon(Icons.support_agent),
          label: const Text('Chat with Support'),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            // Functionality to call support
          },
          icon: const Icon(Icons.call),
          label: const Text('Call Support'),
        ),
      ],
    );
  }
}

// Report an Issue Section Widget
class ReportIssueSection extends StatelessWidget {
  final TextEditingController issueController = TextEditingController();

  ReportIssueSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Report an Issue',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: issueController,
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: 'Describe your issue',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Functionality to submit the issue
            final issue = issueController.text;
            if (issue.isNotEmpty) {
              // Send issue report to backend or support
              issueController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Issue reported successfully.')),
              );
            }
          },
          child: const Text('Submit Issue'),
        ),
      ],
    );
  }
}

// Terms and Conditions / Policies Widget
class TermsAndConditionsSection extends StatelessWidget {
  const TermsAndConditionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Terms & Conditions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text('Rider Agreement'),
          onTap: () {
            // Show rider agreement document
          },
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          onTap: () {
            // Show privacy policy document
          },
        ),
      ],
    );
  }
}
