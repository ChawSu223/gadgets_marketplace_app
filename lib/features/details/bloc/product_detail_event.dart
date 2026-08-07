import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {}

class FetchProductByIdEvent extends ProductDetailEvent {
  String id;
  FetchProductByIdEvent({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
