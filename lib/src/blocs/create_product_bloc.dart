import 'dart:async';
import 'package:tul_entry_app/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class CreateProductBloc with Validators{

  final _nombreController = BehaviorSubject<String>();
  final _skuController = BehaviorSubject<String>();
  final _descripcionController = BehaviorSubject<String>();

  
  Stream<String> get nombreStream => _nombreController.stream.transform(validateProductName);
  Stream<String> get skuStream => _skuController.stream.transform(validateProductName);
  Stream<String> get descripcionStream => _descripcionController.stream.transform(validateProductName);
  Stream<bool>  get camposLlenos => Rx.combineLatest3(nombreStream, skuStream, descripcionStream, (nombre,sku,descripcion) => true);

  Function(String) get cambiarNombre => _nombreController.sink.add;
  Function(String) get cambiarSku => _skuController.sink.add;
  Function(String) get cambiarDescripcion => _descripcionController.sink.add;

  String get nombreProducto => _nombreController.value;
  String get skuProducto => _skuController.value;
  String get descripcionProducto => _descripcionController.value;

  dispose(){
    _nombreController?.close();
    _skuController?.close();
    _descripcionController?.close();
  }

}