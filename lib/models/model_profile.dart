class Profile{
  final String name;
  final String mail;
  final String gender;
  Profile(this.name,this.mail,this.gender);
  Profile.fromJson(Map<String, dynamic> json) :
        name=json['name'],
        mail=json['mail'],
        gender=json['gender'];
}
class Update_Profile{
  final String name;
  final String gender;
  Update_Profile(this.name,this.gender);
}
class Update_Pwd{
  final String pwd;
  final String new_pwd;
  Update_Pwd(this.pwd,this.new_pwd);
}

class AI_Methods{
  final String token;
  AI_Methods(this.token);
}


class SecureData{
  final String data;
  final String key;
  SecureData(this.data,this.key);

  Map<String,String> formatAccessToken(){
    return {"AES_key":key,"access_token":data};
  }
  Map<String,String> formatApiKey(){
    return {"AES_key":key,"api_key":data};
  }
}

