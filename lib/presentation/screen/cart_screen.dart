import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/song/song_entity.dart';
import 'package:music_app/presentation/bloc/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: Stack(
        children: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              return ListView.builder(
                  itemCount: cartState.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartState.items.values.elementAt(index);
                    final songEntity = cartItem.item;
                    return CartItemWidget(
                        songEntity: songEntity, cartItem: cartItem);
                  });
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Checkout'),
                          content:
                              const Text('Are you sure you want to checkout?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<CartCubit>(context).clearCart();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Checkout')),
              )),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.songEntity,
    required this.cartItem,
  });

  final SongEntity songEntity;
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Text(songEntity.title),
          ),
          IconButton(
              onPressed: () =>
                  BlocProvider.of<CartCubit>(context).removeItem(songEntity),
              icon: const Icon(Icons.remove)),
          Text(
            cartItem.quantity.toString(),
          ),
          IconButton(
              onPressed: () =>
                  BlocProvider.of<CartCubit>(context).addItem(songEntity),
              icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
