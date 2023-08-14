class ApiRoutes{
  static const String apiBaseUrl="https://study-savvy.com/api/";
  static const String fileImageUrl="${apiBaseUrl}Files/resources/graph";
  static const String fileAudioUrl="${apiBaseUrl}Files/resources/audio";
  static const String fileUrl="${apiBaseUrl}Files";
  static const String logoutUrl="${apiBaseUrl}User/logout";
  static const String profileUrl="${apiBaseUrl}Information";
  static const String passwordEditUrl="${apiBaseUrl}Information/password_edit";
  static const String apiKeyUrl="${apiBaseUrl}Access_method/api_key";
  static const String accessTokenUrl="${apiBaseUrl}Access_method/access_token";
  static const String articleImproverUrl="${apiBaseUrl}Predict/OCR";
  static const String articleImproverTextUrl="${apiBaseUrl}Predict/OCR_Text";
  static const String fileNlpEditOCRUrl="${apiBaseUrl}NLP_edit/OCR";
  static const String fileNlpEditASRUrl="${apiBaseUrl}NLP_edit/ASR";

  static const String logInUrl="${apiBaseUrl}login/app";
  static const String signUpUrl="${apiBaseUrl}signup";
  static const String emailSendUrl="${apiBaseUrl}verification";
  static const String emailCheckUrl="${apiBaseUrl}verification";
  static const String noteTakerUrl="${apiBaseUrl}predict/ASR";
}