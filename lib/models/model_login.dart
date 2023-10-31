class LoginModel{
  final String email;
  final String password;
  LoginModel(this.email, this.password);
  Map<String,String> formatJson(){
    return {
      "mail": email,
      "password": password, 
    };
  }
}