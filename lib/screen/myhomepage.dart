/*
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  // TPV Key - rzp_test_5sHeuuremkiApj
  //Non-TPV key - rzp_test_0wFRWIZnH65uny
  //Checkout key - rzp_live_ILgsfZCZoFIKMb
  String merchantKeyValue = "rzp_live_ILgsfZCZoFIKMb";
  String amountValue = "100";
  String orderIdValue = "";
  String mobileNumberValue = "8888888888";

  late Razorpay razorpay ;

  @override
  void initState() {
    razorpay = Razorpay("rzp_test_TVS6DclggAQVfA").initUpiTurbo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              RZPEditText(
                controller: keyController,
                textInputType: TextInputType.text,
                hintText: 'Enter Key',
                labelText: 'Merchant Key',
              ),
              RZPEditText(
                controller: amountController,
                textInputType: TextInputType.number,
                hintText: 'Enter Amount',
                labelText: 'Amount',
              ),
              RZPEditText(
                controller: orderIdController,
                textInputType: TextInputType.text,
                hintText: 'Enter Order Id',
                labelText: 'Order Id',
              ),
              RZPEditText(
                controller: mobileNumberController,
                textInputType: TextInputType.number,
                hintText: 'Enter Mobile Number',
                labelText: 'Mobile Number',
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                child: Text(
                  '* Note - In case of TPV the orderId is mandatory.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: RZPButton(
                      widthSize: 200.0,
                      onPressed: () {
                        merchantKeyValue = keyController.text;
                        amountValue = amountController.text;

                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                        razorpay.open(getPaymentOptions());
                      },
                      labelText: 'Standard Checkout Pay',
                    ),
                  ),
                  Expanded(
                    child: RZPButton(
                      widthSize: 200.0,
                      onPressed: () {
                        merchantKeyValue = keyController.text;
                        amountValue = amountController.text;
                        mobileNumberValue = mobileNumberController.text;
                        orderIdValue = orderIdController.text;

                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                        razorpay.open(getTurboPaymentOptions());
                      },
                      labelText: 'Turbo Pay',
                    ),
                  ),
                ],
              ),
              RZPEditText(
                controller: mobileNumberController,
                textInputType: TextInputType.number,
                hintText: 'Enter Mobile Number',
                labelText: 'Mobile Number',
              ),
              RZPButton(
                widthSize: 200.0,
                labelText: "Link New Upi Account",
                onPressed: () {
                  mobileNumberValue = mobileNumberController.text;

                  razorpay.upiTurbo.linkNewUpiAccount(customerMobile: mobileNumberValue,
                      color: "#ffffff",
                      onSuccess: (List<UpiAccount> upiAccounts) {
                        print("Successfully Onboarded Account : ${upiAccounts.length}");
                      },
                      onFailure:(Error error) { ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error : ${error.errorDescription}")));}
                  );
                },
              ),
              RZPButton(
                widthSize: 200.0,
                labelText: "Manage Upi Account",
                onPressed: () {
                  mobileNumberValue = mobileNumberController.text;

                  razorpay.upiTurbo.manageUpiAccounts(customerMobile: mobileNumberValue,
                      color: "#ffffff",
                      onFailure:(Error error) { ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error : ${error.errorDescription}")));}
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, Object> getPaymentOptions() {
    return {
      'key': '$merchantKeyValue',
      'amount': int.parse(amountValue),
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '$mobileNumberValue',
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
  }

  Map<String, Object> getTurboPaymentOptions() {
    return {
      'amount': int.parse(amountValue),
      'currency': 'INR',
      'prefill':{
        'contact':'$mobileNumberValue',
        'email':'test@razorpay.com'
      },
      'theme':{
        'color':'#0CA72F'
      },
      'send_sms_hash':true,
      'retry':{
        'enabled':false,
        'max_count':4
      },
      'key': '$merchantKeyValue',
      'order_id':'$orderIdValue',
      'disable_redesign_v15': false,
      'experiments.upi_turbo':true,
      'ep':'https://api-web-turbo-upi.ext.dev.razorpay.in/test/checkout.html?branch=feat/turbo/tpv'
    };
  }


  //Handle Payment Responses

  void handlePaymentErrorResponse(PaymentFailureResponse response){

    */
/** PaymentFailureResponse contains three values:
     * 1. Error Code
     * 2. Error Description
     * 3. Metadata
     **//*

    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.message.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){

    */
/** Payment Success Response contains three values:
     * 1. Order ID
     * 2. Payment ID
     * 3. Signature
     **//*

    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class RZPButton extends StatelessWidget {
  String labelText;
  VoidCallback onPressed;
  double widthSize = 100.0;

  RZPButton(
      {required this.widthSize,
        required this.labelText,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: 50.0,
      margin: EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 12.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          labelText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigoAccent),
        ),
      ),
    );
  }
}

class RZPEditText extends StatelessWidget {
  String hintText;
  String labelText;
  TextInputType textInputType;
  TextEditingController controller;

  RZPEditText(
      {required this.textInputType,
        required this.hintText,
        required this.labelText,
        required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}*/
