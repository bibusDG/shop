import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/entities/basket.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoading()) {

    final Basket _newBasket = Basket(basketContent: []);

    on<AddProductToBasket>((event, emit){
      // if(state is BasketLoaded){
      //   final state = this.state as BasketLoaded;
      //   emit(BasketLoaded(basket: Basket(basketContent: List.from(state.basket.basketContent)..add(event.product))));
      // }
      _newBasket.basketContent.add(event.product);
      emit(BasketLoaded(basket: _newBasket));
    });

    on<RemoveProductFromBasket>((event, emit){
      _newBasket.basketContent.remove(event.product);
      emit(BasketLoaded(basket: _newBasket));
    });

    on<BasketInit>((event, emit) async{
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(BasketLoaded(basket: _newBasket));
    });


  //
  //   on<BasketEvent>((event, emit) async {
  //     if (event is BasketInit) {
  //        _basketInit();
  //     }else if (event is AddProductToBasket){
  //       _addProductToBasket(event, state);
  //     }else if (event is RemoveProductFromBasket){
  //       _removeProductFromBasket(event, state);
  //     }
  //     // TODO: implement event handler
  //   });
  // }
  //
  // Stream<BasketState> _basketInit() async* {
  //   yield BasketLoading();
  //   try{
  //     await Future<void>.delayed(const Duration(seconds: 1));
  //     yield const BasketLoaded(basket: Basket.empty());
  //   }catch(error){}
  // }
  //
  // Stream<BasketState> _addProductToBasket(AddProductToBasket event, BasketState state) async*{
  //   if(state is BasketLoaded){
  //     try{
  //        yield BasketLoaded(basket: Basket(basketContent: List.from(state.basket.basketContent)..add(event.product)));
  //     }catch(error){}
  //   }
  // }
  //
  // Stream<BasketState> _removeProductFromBasket(RemoveProductFromBasket event, BasketState state) async*{
  //   if(state is BasketLoaded){
  //     try{
  //       yield BasketLoaded(basket: Basket(basketContent: List.from(state.basket.basketContent)..remove(event.product)));
  //     }catch(error){}
  //   }
  }
}
