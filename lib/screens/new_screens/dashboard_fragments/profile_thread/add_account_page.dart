import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
// import 'package:m_n_m_rider/commons/app_colors.dart';
import 'package:m_n_m_rider/widgets/custom_button.dart';
import '../../../../utils/providers/payment_account_provider.dart';

class AddMomoAccountPage extends ConsumerStatefulWidget {
  const AddMomoAccountPage({super.key});
  static const routeName = '/add-account';
  @override
  ConsumerState<AddMomoAccountPage> createState() => _AddMomoAccountPageState();
}

class _AddMomoAccountPageState extends ConsumerState<AddMomoAccountPage> {
  final TextEditingController _mobileNumberController = TextEditingController();
  String _selectedNetwork = 'MTN';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(IconlyLight.arrow_left_2),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
        title: Text(
          'Add Account',
          style: theme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.03),
            Text('Add Mobile Money Wallet', style: theme.titleMedium),
            SizedBox(height: size.height * 0.004),
            Text('Add a mobile account to receive payments',
                style: theme.bodyMedium),
            SizedBox(height: size.height * 0.024),
            Text('Mobile money number', style: theme.bodyLarge),
            SizedBox(height: size.height * 0.01),
            TextFormField(
              controller: _mobileNumberController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'E.g. 024 242 4242',
                hintStyle: theme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: size.height * 0.024),
            Text('Select network', style: theme.bodyLarge),
            SizedBox(height: size.height * 0.01),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: _selectedNetwork,
                items: ['MTN', 'Telecel'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedNetwork = newValue!;
                  });
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              onTap: () {
                final newAccount = Account(
                  name: _selectedNetwork,
                  number: int.parse(_mobileNumberController.text),
                  network:
                      _selectedNetwork == 'MTN' ? Network.MTN : Network.Telecel,
                );
                ref.read(accountProvider.notifier).addAccount(newAccount);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account successfully added!'),
                  ),
                );
                Navigator.of(context).pop();
              },
              title: 'Save this wallet',
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
