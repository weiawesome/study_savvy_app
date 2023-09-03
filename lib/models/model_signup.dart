class SignUpModel{
  final String gender;
  final String mail;
  final String name;
  final String password;
  SignUpModel(this.gender, this.mail, this.name, this.password);
  Map<String,String> formatJson(){
    return {
        "gender":gender,
        "mail":mail,
        "name":name,
        "password":password,
    };
  }
}
