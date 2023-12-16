import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:razorpaydemo/screen/razorpay_response_model.dart';

import 'constant.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay? _razorpay;
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: " Payment Successfully");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Payment Successfully");
  }

  // Future<dynamic> createOrder() async {
  //   var mapHeader = <String, String>{};
  //   mapHeader['Authorization'] =
  //   "Basic cnpwX3Rlc3RfVFZTNkRjbGdnQVFWZkE6VkRLeEJOMlR3a0diYmNOaVp5bDg5QkRX";
  //   mapHeader['Accept'] = "application/json";
  //   mapHeader['Content-Type'] = "application/x-www-form-urlencoded";
  //   var map = <String, String>{};
  //   setState(() {
  //     map['amount'] = "${(num.parse(amount.text) * 100)}";
  //   });
  //   map['currency'] = "INR";
  //   map['receipt'] = "receipt1";
  //   print("map $map");
  //   var response = await http.post(Uri.https("api.razorpay.com", "/v1/orders"),
  //       headers: mapHeader, body: map);
  //   print("...." + response.body);
  //   if (response.statusCode == 200) {
  //     RazorpayOrderResponse data =
  //     RazorpayOrderResponse.fromJson(json.decode(response.body));
  //     openCheckout(data);
  //   } else {
  //     Fluttertoast.showToast(msg: "Something went wrong!");
  //   }
  // }
  //
  // void openCheckout(RazorpayOrderResponse data) async {
  //   var options = {
  //     'key': RazorpayApiKey,
  //     'amount': "${(num.parse(amount.text) * 100)}",
  //     'name': 'Razorpay Test',
  //     'description': '',
  //     'order_id': '${data.id}',
  //   };
  //
  //   try {
  //     _razorpay?.open(options);
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //   }
  // }
  Future<void> createOrder() async {
    try {
      Map<String, dynamic> orderRequest = {
        'amount': 50000, // amount in the smallest currency unit
        'currency': 'INR',
        'receipt': 'order_rcptid_11',
      };

      final response = await http.post(
        Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: {
          'Content-Type': 'application/json',
          // Add your Razorpay API key in the Authorization header
          'Authorization': 'Basic your_api_key_here',
        },
        body: json.encode(orderRequest),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        // Handle successful order creation
        print('Order created: ${responseData['id']}');
        openCheckout(responseData);
      } else {
        // Handle unsuccessful order creation
        print('Failed to create order: ${response.body}');
      }
    } catch (e) {
      // Handle Exception
      print(e.toString());
    }
  }
  void openCheckout(Map data) async {
    var options = {
      'key': 'rzp_test_TVS6DclggAQVfA',
      'amount': amount.text, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': '${data['id']}', // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 60, // in seconds
      // 'prefill': {
      //   'contact': '9123456789',
      //   'email': 'gaurav.kumar@example.com'
      // }
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Razorpay integration",style: TextStyle(color: Colors.green,fontSize: 16),),
      ),
      body: SafeArea(child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green,width: 1)
                  ),
                  hintText: "Amount"),
            ),
          ),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            onPressed: () => createOrder(),
            child: Text("PAY",style: TextStyle(color: Colors.white,fontSize: 16),),)
        ],
      )),
    );
  }
}