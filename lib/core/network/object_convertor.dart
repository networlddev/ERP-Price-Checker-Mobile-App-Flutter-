import 'package:netpospricechecker/models/activation_key.dart';
import 'package:netpospricechecker/models/validate_model.dart';

class CreateObject{
  static const validateModel = 'validate';
  static const activationKeyModel = 'activation';

 static dynamic getObject(dynamic data, String modelName){
    switch (modelName){
      case validateModel:
      return Validation.fromJson(data);
      case activationKeyModel:
      return ActivationKey.fromJson(data);
      default:
      return 'No model Fonund';
    }

  }
}