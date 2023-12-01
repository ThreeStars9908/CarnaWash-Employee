import 'package:app_employee/data/data.dart';
import 'package:app_employee/infra/providers/products_provider.dart';
import 'package:app_employee/ui/pages/pay_page.dart';
import 'package:app_employee/ui/pages/training_module_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ui.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget{
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}
class _ProductsPageState extends State<ProductsPage> {

  late ProductsProvider productsProvider;
  late List<ProductsModel?> listProducts;
  int widgetIndex = 0;
  int itemIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      productsProvider = Provider.of(
        context,
        listen: false,
      );
      await productsProvider.loadProducts(context);
      listProducts = productsProvider.products;
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    children: [
                      backButtonComponent(context),
                      const Text(
                        'Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  (widgetIndex == 0)?
                  Column(
                    children: List.generate(
                      listProducts.length,
                          (index) {
                        return productBox(
                          context,index, listProducts[index]!.name, listProducts[index]!.price, listProducts[index]!.photo,
                        );
                      },
                    ),
                  ):
                  ProductPurchaseWidget(
                    productID: listProducts[itemIndex]!.id,
                    productName: listProducts[itemIndex]!.name,
                    productPrice: listProducts[itemIndex]!.price,
                    productImageUrl: listProducts[itemIndex]!.photo,
                    information: listProducts[itemIndex]!.information,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector productBox(
      BuildContext context,
      int Index,
      String productName,
      int productPrice,
      String productImageUrl,
      ) {
    return GestureDetector(
      onTap: (){

      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side: Product Name
                        const Text(
                          'Product Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Right side: Quantity (1L)
                        Text(
                          productName,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.network(
                            Constants.BACKEND_BASE_URL + '/' + productImageUrl, // Replace with your image URL
                            width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
                            height: MediaQuery.of(context).size.width * 0.4, // Adjust height as needed
                            fit: BoxFit.cover, // BoxFit to control how the image is inscribed into the box
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\$ $productPrice',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    const Text(
                                      'Lasts up to 60 washes',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widgetIndex = 1;
                                    itemIndex = Index;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.amber, // Set the button color to yellow
                                ),
                                child: Text('Buy Now'),
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
  class ProductPurchaseWidget extends StatefulWidget {
    final String productName;
    final int productPrice;
    final String productImageUrl;
    final String information;
    final int? productID;

    const ProductPurchaseWidget({
      Key? key,
      required this.productID,
      required this.productName,
      required this.productPrice,
      required this.productImageUrl,
      required this.information,
    }) : super(key: key);

    @override
    _ProductPurchaseWidgetState createState() => _ProductPurchaseWidgetState();
  }

  class _ProductPurchaseWidgetState extends State<ProductPurchaseWidget> {
    // Define a variable to hold the quantity
    int quantity = 1;

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          // Handle the tap event
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left side: Product Name
                          const Text(
                            'Product Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          // Right side: Quantity (1L)
                          Text(
                            widget.productName,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.network(
                            Constants.BACKEND_BASE_URL + '/' + widget.productImageUrl,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.4,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\$ ${widget.productPrice}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    const Text(
                                      'Lasts up to 60 washes',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Replace the ElevatedButton with Row
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Decrease quantity
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.remove_circle_outline),
                                  ),
                                  Text(
                                    '$quantity',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Increase quantity
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        widget.information,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      '\$ ${widget.productPrice * quantity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width * 0.85, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(237, 189, 58, 1),
                  ),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PayPage(payAmount: widget.productPrice * quantity, payQuantity: quantity,productID: widget.productID,), ),
                  );
                },
                child: const Text(
                  'Payment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }