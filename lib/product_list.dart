import 'package:cart/cart_model.dart';
import 'package:cart/cart_provider.dart';
import 'package:cart/cart_screen.dart';
import 'package:cart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  DBHelper? dbHelper = DBHelper();

  List<String>  productname = ['Mango','Orange','Grapes','Banana','Cherry','Peach','Mixed Fruits'];
  List<String> productunit = ['KG','Dozen', 'KG','Dozen','KG','KG','KG'];
  List<int> productprice = [10,20,30,40,50,60,70];
  List<String> productimage = [
    'https://media.istockphoto.com/id/168370138/photo/mango.jpg?s=1024x1024&w=is&k=20&c=HBXIjdVwjydQmINVBRCxeVivTdejyHsZPgVWLiniGRM=',
    'https://media.istockphoto.com/id/185284489/photo/orange.jpg?s=1024x1024&w=is&k=20&c=q5eBnLHG9tiKv0Hl2lPVF6nnEYCXQtFYfh0u9mvHwaI=',
    'https://media.istockphoto.com/id/842928214/photo/fresh-grapes-in-the-basket.jpg?s=1024x1024&w=is&k=20&c=62dsL8R4QGTxfKxl4BfSOzFBFuAoPVpUaI4PtdqbD7o=',
    'https://media.istockphoto.com/id/173242750/photo/banana-bunch.jpg?s=1024x1024&w=is&k=20&c=mzktjTrLz_ZdKClKR5btvo5cBY-BJ4h4QOT8LVflB2M=',
    'https://media.istockphoto.com/id/172315512/photo/sweet-cherries.jpg?s=1024x1024&w=is&k=20&c=bYVKOqiGg-RujtMX26ba5wigj0jd94s1YvXST4tM7BM=',
    'https://media.istockphoto.com/id/528065586/photo/peach-fruit-with-slice-isolated-on-white-background.jpg?s=1024x1024&w=is&k=20&c=YkV0NzUJ7PYfdkSRrpnXq2PceGDjkVXM43XfuTM2_Jw=',
    'https://media.istockphoto.com/id/476953636/photo/fresh-fruit-salad.jpg?s=1024x1024&w=is&k=20&c=Xj6XBiy-ozZzYd2q8FGmYDmbWIYoEpJCbcvO_xfkoiU=',
  ];


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductList'),
        centerTitle: true,
        actions:  [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
              child: badges.Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child){
                    return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white),);
                },
                ),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: productname.length,
                itemBuilder: (context,index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                height: 100,
                                width: 100,
                                image: NetworkImage(productimage[index].toString()),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productname[index].toString(),
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(productunit[index].toString() + " " +r"$" + productprice[index].toString(),
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                    ),
                                   Align(
                                     alignment: Alignment.centerRight,
                                     child: InkWell(
                                       onTap: (){
                                         print(index);
                                         print(index);
                                         print(productname[index].toString());
                                         print(productprice[index].toString());
                                         print(productprice[index]);
                                         print('1');
                                         print(productunit[index].toString());
                                         print(productimage[index].toString());

                                          dbHelper!.insert(
                                           Cart(id: index,
                                               productId: index.toString(),
                                               productName: productname[index].toString(),
                                               initialprice: productprice[index],
                                               productprice: productprice[index],
                                               quantity: 1,
                                               unitTag: productunit[index].toString(),
                                               image: productimage[index].toString(),
                                           ),
                                          ).then((value){
                                            print("product is added to cart");
                                            cart.addTotalPrice(double.parse(productprice[index].toString()));
                                            cart.addCounter();

                                          }).onError((error, stackTrace){
                                            print(error.toString());
                                          });
                                       },
                                       child: Container(
                                         height: 35,
                                         width: 100,
                                         decoration: BoxDecoration(
                                           color: Colors.green,
                                           borderRadius: BorderRadius.circular(8.0)
                                         ),
                                         child: Center(
                                           child: Text('Add to Cart',
                                           style: TextStyle(color: Colors.white),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),

        ],
      ),
    );
  }
}


