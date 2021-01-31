import 'package:rxdart/rxdart.dart';

class CartBloc{

  final _statusController = BehaviorSubject<String>();

  Stream<String> get statusStream => _statusController.stream;
  Function(String) get cambiarStatus => _statusController.sink.add;

  String get statusCart => _statusController.value;

  updateState(String status){
    (status != null) ? _statusController.sink.add(status) : _statusController.sink.addError("No value");
  }

  dispose(){
    _statusController?.close();
  }

}