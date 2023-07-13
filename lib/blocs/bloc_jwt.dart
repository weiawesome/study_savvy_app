import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';

abstract class JWTEvent {}
class JWTEventGet extends JWTEvent{}
class JWTEventDelete extends JWTEvent{}
class JWTBloc extends Bloc<JWTEvent,String?> {
  final JwtService jwtService;
  JWTBloc({JwtService? jwtService}):jwtService=jwtService??JwtService(),super(null){
    on<JWTEvent>((event,emit) async {
      if (event is JWTEventGet){
        String? jwt = await jwtService!.getJwt();
        emit(jwt);
      }
      else{
        await jwtService!.deleteJwt();
        emit(null);
      }
    });
  }
}