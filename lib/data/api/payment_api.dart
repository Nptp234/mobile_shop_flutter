import 'dart:convert';

// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/data/models/payment.dart';

class PaymentApi {

  Future<http.Response> _getData() async{
    try{
      String? key = await read();
      String? url = await readUrl('paymentUrl');

      final res = await http.get(
        Uri.parse(url!), 
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json'
        }
      );
      return res;
    }
    catch(e){
      rethrow;
    }
  }

  Future<List<Payment>> getAll() async{
    try{
      final response = await _getData();

      if(response.statusCode==200){
        final body = jsonDecode(response.body);

        // List<Payment> lst = [];
        // for(var record in body['records']){
        //   var field = record['fields'];
        //   lst.add(Payment.fromJson(field));
        // }
        // return lst;

        return (body['records'] as List)
          .map((record) => Payment.fromJson(record['fields']))
          .toList();
      }
      else{return [];}
    }
    catch(e){
      rethrow;
    }
  }

  //-------------------------------------------

  // Stripe
  Map<dynamic, dynamic>? paymentIntent;

  // Future<Map<dynamic, dynamic>> createPaymentIntent(String amount, String currency) async{
  //   try{
  //     String? secretKey = await readStripe();
  //     String? url = await readUrl('stripeUrl');

  //     final body = {
  //       'amount': '${(int.parse(amount)*100)}',
  //       'currency': currency,
  //       'payment_method_type': 'card'
  //     };

  //     final response = await http.post(
  //       Uri.parse('$url/payment_intents'),
  //       headers: {
  //         'Authorization': 'Bearer $secretKey',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //       body: jsonEncode(body)
  //     );

  //     if(response.statusCode==200){
  //       return jsonDecode(response.body);
  //     }else{
  //       return {};
  //     }
  //   }
  //   catch(e){
  //     rethrow;
  //   }
  // }

  // displayPaymentSheet(BuildContext context) async{
  //   try{
  //     await Stripe.instance.presentPaymentSheet();

  //     //notify when payment is done
  //     // ignore: use_build_context_synchronously
  //     QuickAlert.show(context: context, type: QuickAlertType.success, text: "Paid Successfully!");
  //     paymentIntent = null;
      
  //   } on StripeException catch (e){
  //     //payment have error or being cancelled
  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e'))
  //     );
  //     // ignore: use_build_context_synchronously
  //     QuickAlert.show(context: context, type: QuickAlertType.error, text: "Payment Cancelled!");
  //   }
  //   catch(e){
  //     rethrow;
  //   }
  // }

  // Future<void> makePayment(BuildContext context, String amount, String currency) async{
  //   try{  
  //     paymentIntent = await createPaymentIntent(amount, currency);
  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         paymentIntentClientSecret: paymentIntent!['client_secret'],
  //         googlePay: const PaymentSheetGooglePay(
  //           merchantCountryCode: "VN",
  //           currencyCode: "VND",
  //           testEnv: true,
  //         ),
  //         merchantDisplayName: 'Flutterwings',
  //       )
  //     );

  //     // ignore: use_build_context_synchronously
  //     displayPaymentSheet(context);
  //   }
  //   catch(e){
  //     rethrow;
  //   }
  // }


}
