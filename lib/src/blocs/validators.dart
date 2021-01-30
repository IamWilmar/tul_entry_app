
import 'dart:async';

class Validators{

  final validateProductName = StreamTransformer<String, String>.fromHandlers(
    handleData: (productName, sink){
      if(productName.length > 3){
        sink.add(productName);
      }else{
        sink.addError("Entrada de texto mas larga, por favor");
      }
    }
  );
}