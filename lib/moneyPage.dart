import 'package:flutter/material.dart';
import 'dashboardPage.dart';


class SendMoneyPage extends StatefulWidget {
  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? selectedPaymentMethod;
  bool isFavorite = false;
  bool showSuccessMessage = false;

  void validateAndSend() {
  if (recipientController.text.isEmpty) {
    showError('Recipient name cannot be empty');
  } else if (double.tryParse(amountController.text) == null ||
      double.parse(amountController.text) <= 0) {
    showError('Amount must be a positive number');
  } else {
    // Simulate a successful transaction
    setState(() {
      showSuccessMessage = true;
    });

    // Navigate to the Dashboard page after a brief delay
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => DashboardPage(),
      ));
    });
  }
}


  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Recipient Name'),
              controller: recipientController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: amountController,
            ),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              hint: Text('Select Payment Method'),
              items: <String>['Credit Card', 'PayPal', 'Bank Transfer']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue;
                });
              },
            ),
            SwitchListTile(
              title: Text('Mark as Favorite'),
              value: isFavorite,
              onChanged: (bool value) {
                setState(() {
                  isFavorite = value;
                });
              },
            ),
            SizedBox(height: 20),
            SendMoneyButton(onPressed: validateAndSend),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: showSuccessMessage ? 50 : 0,
              child: Center(child: Text('Transaction Successful!', style: TextStyle(color: Colors.green))),
            ),
          ],
        ),
      ),
    );
  }
}

class SendMoneyButton extends StatelessWidget {
  final VoidCallback onPressed;

  SendMoneyButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Send Money'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 15.0)),
      ),
    );
  }
}
