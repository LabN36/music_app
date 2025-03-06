import 'package:bloc/bloc.dart';
import 'package:music_app/domain/song/song_entity.dart';

abstract class CartEvent {}

class AddItemToCartEvent extends CartEvent {
  final SongEntity item;

  AddItemToCartEvent(this.item);
}

class RemoveItemToCartEvent extends CartEvent {
  final SongEntity item;

  RemoveItemToCartEvent(this.item);
}

class CartItem {
  final SongEntity item;
  final int quantity;

  CartItem(this.item, this.quantity);
}

class CartState {
  Map<String, CartItem> items = {};
  int total;
  final bool isLoading;
  final String error;

  CartState({
    required this.items,
    required this.total,
    required this.isLoading,
    required this.error,
  });

  CartState copyWith({required Map<String, CartItem> items}) {
    return CartState(
      items: items,
      total: items.values.fold(0, (total, item) => total + item.quantity),
      isLoading: isLoading,
      error: error,
    );
  }

  // getTotalCount() {}
}

class CartCubit extends Cubit<CartState> {
  CartCubit()
      : super(CartState(total: 0, items: {}, isLoading: false, error: ''));

  void addItem(SongEntity item) {
    final itemKey = item.id;
    final currentItem = state.items[itemKey];
    final newQuantity = (currentItem?.quantity ?? 0) + 1;
    final newItem = CartItem(item, newQuantity);
    final newItems = {...state.items, itemKey: newItem};
    emit(state.copyWith(items: newItems));
  }

  void removeItem(SongEntity item) {
    final itemKey = item.id;
    final currentItem = state.items[itemKey];
    if (currentItem == null) return;
    final newQuantity = currentItem.quantity - 1;
    if (newQuantity <= 0) {
      final newItems = {...state.items};
      newItems.remove(itemKey);
      emit(state.copyWith(items: newItems));
    } else {
      final newItem = CartItem(item, newQuantity);
      final newItems = {...state.items, itemKey: newItem};
      emit(state.copyWith(items: newItems));
    }
  }

  void clearCart() {
    emit(state.copyWith(items: {}));
  }
}
