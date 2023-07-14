import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';

abstract class JWTEvent {}
class JWTEventGet extends JWTEvent{}
class JWTEventDelete extends JWTEvent{}
class JWTEventUnknown extends JWTEvent{}
class JWTBloc extends Bloc<JWTEvent,String?> {
  final JwtService jwtService;
  JWTBloc({JwtService? jwtService}):jwtService=jwtService??JwtService(),super(null){
    jwtService ??= JwtService();
    on<JWTEvent>((event,emit) async {
      if (event is JWTEventGet){
        String? jwt = await jwtService!.getJwt();
        emit(jwt);
      }
      else if (event is JWTEventDelete){
        await jwtService!.deleteJwt();
        emit(null);
      }
      else{
        throw Exception("Error event in jwt");
      }
    });
  }
}