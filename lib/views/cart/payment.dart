import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/payment_api.dart';

class PaymentPage extends StatefulWidget{
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Make Payment'),
          onPressed: () async {
            // await PaymentApi().makePayment(context, '3', 'VND');
          },
        ),
      ),
    );
  }

}