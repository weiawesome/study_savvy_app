import 'package:flutter_test/flutter_test.dart';
import 'package:study_savvy_app/models/profile/model_profile.dart';

void main(){
  group('Profile', () {
    test('Profile object value test', () {
      const String testName= 'Test name';
      const String testMail = 'Test mail';
      const String testGender = 'Test gender';
      final profile = Profile(testName,testMail,testGender);

      expect(profile.name, testName);
      expect(profile.mail, testMail);
      expect(profile.gender, testGender);

    });
    test('Profile object fromJson method test', () {
      const String testName= 'Test name';
      const String testMail = 'Test mail';
      const String testGender = 'Test gender';
      var testJson={
        "name":testName,
        "mail":testMail,
        "gender":testGender
      };
      final profile = Profile.fromJson(testJson);

      expect(profile.name, testName);
      expect(profile.mail, testMail);
      expect(profile.gender, testGender);

    });
  });
  group('UpdateProfile', () {
    test('UpdateProfile object value test', () {
      const String testName= 'Test name';
      const String testGender = 'Test gender';
      final updateProfile = UpdateProfile(testName,testGender);

      expect(updateProfile.name, testName);
      expect(updateProfile.gender, testGender);

    });
  });
  group('UpdatePwd', () {
    test('UpdatePwd object value test', () {
      const String testOldPwd= 'Test oldPwd';
      const String testNewPwd = 'Test newPwd';

      final updatePwd = UpdatePwd(testOldPwd, testNewPwd);

      expect(updatePwd.currentPassword, testOldPwd);
      expect(updatePwd.EditPassword, testNewPwd);

    });
    test('UpdatePwd object formatJson method test', () {
      const String testOldPwd= 'Test oldPwd';
      const String testNewPwd = 'Test newPwd';

      final updatePwd = UpdatePwd(testOldPwd, testNewPwd);

      expect(updatePwd.formatJson(),{"original_pwd":testOldPwd,"new_pwd":testNewPwd});

    });
  });
  group('AIMethods', () {
    test('AIMethods object value test', () {
      const String testToken= 'Test token';

      final updateProfile = AIMethods(testToken);

      expect(updateProfile.token,testToken);

    });
  });
  group('SecureData', () {
    test('SecureData object value test', () {
      const String testData= 'Test data';
      const String testKey = 'Test key';

      final secureData=SecureData(testData, testKey);

      expect(secureData.data,testData);
      expect(secureData.key,testKey);

    });
    test('SecureData object formatAccessToken method test', () {
      const String testData= 'Test data';
      const String testKey = 'Test key';

      final secureData=SecureData(testData, testKey);

      expect(secureData.formatAccessToken(),{"AES_key":testKey,"access_token":testData});

    });
    test('SecureData object formatApiKey method test', () {
      const String testData= 'Test data';
      const String testKey = 'Test key';

      final secureData=SecureData(testData, testKey);

      expect(secureData.formatApiKey(),{"AES_key":testKey,"api_key":testData});

    });
  });
}