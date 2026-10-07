import 'package:bloc/bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAdd);
    on<RemoveFromCart>(_onRemove);
    on<DeleteFromCart>(_onDelete);
    on<ClearCart>(_onClear);
  }

  void _onAdd(AddToCart event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items);
    final idx = items.indexWhere((i) => i.product.id == event.product.id);
    if (idx >= 0) {
      items[idx].quantity++;
    } else {
      items.add(CartItem(product: event.product));
    }
    emit(state.copyWith(items));
  }

  void _onRemove(RemoveFromCart event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items);
    final idx = items.indexWhere((i) => i.product.id == event.product.id);
    if (idx >= 0) {
      if (items[idx].quantity > 1) {
        items[idx].quantity--;
      } else {
        items.removeAt(idx);
      }
    }
    emit(state.copyWith(items));
  }

  void _onDelete(DeleteFromCart event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items)
      ..removeWhere((i) => i.product.id == event.product.id);
    emit(state.copyWith(items));
  }

  void _onClear(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith([]));
  }
}
