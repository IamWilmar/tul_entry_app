import 'package:rxdart/rxdart.dart';

class CartBloc{

  final _statusController = BehaviorSubject<String>();

  Stream<String> get statusStream => _statusController.stream;
  Function(String) get cambiarStatus => _statusController.sink.add;

  String get statusCart => _statusController.value;

  dispose(){
    _statusController?.close();
  }

}