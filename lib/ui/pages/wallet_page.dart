import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../infra/infra.dart';
import '../ui.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider = Provider.of(context, listen: false);

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
                            'Wallet',
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
                            'Register another credit card',
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget creditcardBox(
    BuildContext context,
    CardModel card,
  ) {
    WalletProvider walletProvider = Provider.of(context);
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
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
                    const Image(
                      height: 30,
                      // MUDAR IMAGEM DE ACORDO COM O CARTÃO
                      image: AssetImage('images/mastercard-logo.png'),
                    ),
                    Row(
                      children: [
                        IconButton(
                            padding: const EdgeInsets.only(top: 10),
                            splashRadius: 26,
                            iconSize: 26,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WalletEditPage(preData: card),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit_outlined)),
                        IconButton(
                            padding: const EdgeInsets.only(top: 10),
                            splashRadius: 26,
                            iconSize: 26,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text(
                                      'Are you sure you want to DELETE this card?'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () async =>
                                          await walletProvider.deleteCard(
                                        context,
                                        card.id!,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete_outline)),
                      ],
                    ),
                  ],
                ),
                Text(
                  '**** **** **** ${card.last_digits}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Text(
                  card.name,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${card.date} - ***',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
