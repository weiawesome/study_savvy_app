class Profile{
  final String name;
  final String mail;
  final String gender;
  Profile(this.name,this.mail,this.gender);
  Profile.fromJson(Map<String, dynamic> json) :
        name=json['name'],
        mail=json['mail'],
        gender=json['gender'];
  @override
  String toString(){
    return "Profile $name $mail $gender";
  }
}
class UpdateProfile{
  final String name;
  final String gender;
  UpdateProfile(this.name,this.gender);
  Map<String,String> formatJson(){
    return {
      "name": name,
      "gender": gender
    };
  }
}
class UpdatePwd{
  final String currentPassword;
  final String EditPassword;
  UpdatePwd(this.currentPassword,this.EditPassword);
  Map<String,String> formatJson(){
    return {
      "current_password": currentPassword,
      "edit_password": EditPassword
    };
  }
}

class AIMethods{
  final String token;
  AIMethods(this.token);
}


class SecureData{
  final String data;
  final String key;
  SecureData(this.data,this.key);

  Map<String,String> formatAccessToken(){
    return {"aes_key":key,"access_token":data};
  }
  Map<String,String> formatApiKey(){
    return {"aes_key":key,"api_key":data};
  }
}

