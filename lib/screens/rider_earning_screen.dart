import 'package:flutter/material.dart';

class RiderEarningsScreen extends StatelessWidget {
  const RiderEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Earnings Overview
            EarningsOverview(),

            SizedBox(height: 20),

            // Completed Trips Section
            Expanded(
              child: CompletedTripsList(),
            ),

            // Payout Button
            PayoutButton(),
          ],
        ),
      ),
    );
  }
}

// Widget to display total earnings overview
class EarningsOverview extends StatelessWidget {
  const EarningsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Earnings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '\$85.00',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'This Week',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '\$520.00',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'This Month',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '\$1,750.00',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget to display the list of completed trips
class CompletedTripsList extends StatelessWidget {
  const CompletedTripsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Example data
      itemBuilder: (context, index) {
        return TripEarningsCard(
          tripId: '#${index + 1}123',
          tripDate: 'October 22, 2024',
          earnings: '\$20.00',
        );
      },
    );
  }
}

// Widget for each trip earnings card
class TripEarningsCard extends StatelessWidget {
  final String tripId;
  final String tripDate;
  final String earnings;

  const TripEarningsCard({
    super.key,
    required this.tripId,
    required this.tripDate,
    required this.earnings,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text('Trip ID: $tripId'),
        subtitle: Text('Date: $tripDate'),
        trailing: Text(
          earnings,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Payout Button Widget
class PayoutButton extends StatelessWidget {
  const PayoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Functionality to request payout
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(double.infinity, 50), // Full width button
        ),
        child: const Text(
          'Request Payout',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
