import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';
import '../ui.dart';

class PayPage extends StatefulWidget {
  int? payAmount;
  int? payQuantity;
  int? productID;
  PayPage({super.key, this.payAmount, this.payQuantity, this.productID});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {

  int purchased = 0;
  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider = Provider.of(context, listen: false);
    TextEditingController codeController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[100]!,
      bottomNavigationBar: navigationBarComponent(context),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          backButtonComponent(context),
                          const Text(
                            'Payment',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      notificationGeralButtonComponent(context),
                    ],
                  ),
                  (purchased == 0) ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Do you have a coupon?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      geralTextInput(
                        context: context,
                        text: 'Type the code',
                        textController: codeController,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(229, 229, 229, 1),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '\$ ${widget.payAmount}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          Column(
                            children: List.generate(
                              walletProvider.cards.length,
                                  (index) {
                                return creditcardBox(
                                  context,
                                  walletProvider.cards[index],
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WalletEditPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Pay with another credit card',
                                style: TextStyle(
                                  color: Color.fromRGBO(237, 189, 58, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      : purchasedWidget(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget purchasedWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7, // Set a fixed height
      child: const Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'Item Purchased',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'You will be informed when you’ll receive the item through.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector creditcardBox(
      BuildContext context,
      CardModel card,
      ) {
    WalletProvider walletProvider = Provider.of(context);
    return
      GestureDetector(
        onTap: (){
          setState((){
            purchased = 1;

          });
          setState(() async{
            await walletProvider.payProducts(context, widget.productID!, widget.payQuantity!, widget.payAmount!);
          });
      },
      child:
        Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                color: Colors.blue, // Set the border color to blue
                width: 2.0, // Set the border width
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(), // Add Spacer to push the image to the right
                      Image(
                        height: 30,
                        image: AssetImage('images/mastercard-logo.png'),
                      ),
                    ],
                  ),
                  Text(
                    'Pay Credit Card **** ${card.last_digits}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ));
  }

}
