import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges; // Importing the badges package with a prefix

import 'cart_model.dart';
import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key); // Fixed the syntax of the constructor

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        centerTitle: true,
        actions: [
          badges.Badge( // Used Badge from the badges package with the prefix
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child){
                return Text(value.getCounter().toString(), style: TextStyle(color: Colors.white),);
              },
            ),
            child: Icon(Icons.shopping_bag_outlined),
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
        future: cart.getData(),
        builder:(context, AsyncSnapshot<List<Cart>> snapshot){
          if(snapshot.hasData){
            return Expanded(
                child:  ListView.builder(
                    itemCount: snapshot.data!.length,
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
                                    image: NetworkImage(snapshot.data![index].image.toString()),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data![index].productName.toString(),
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(snapshot.data![index].unitTag.toString() + " " +r"$" +snapshot.data![index].productprice.toString(),
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: (){

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
            );

          }
          return Text('');
        }),
          Consumer<CartProvider>(
            builder: (context, CartProvider cart, child) {
              return Column(
                children: [
                  ReusableWidget(title: 'Sub Total', value: r'$' + cart.getTotalPrice().toStringAsFixed(2),)
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
class ReusableWidget extends StatelessWidget{
  final String title , value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.subtitle2,),
          Text(value.toString(), style: Theme.of(context).textTheme.subtitle2,)
        ],
      ),
    );
  }
}
