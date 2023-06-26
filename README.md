# study_savvy_app

我們使用 BLoC架構 建立 Flutter_App
重點是我們是很有架構的去建立 不懂記得去研究
目前我只講最重要部分
```
├── README.md
├── lib
│   ├── blocs
│   │   ├── blocs.dart
│   │
│   ├── models
│   │   ├── models.dart
│   │
│   ├── screens
│   │   ├── screens.dart
│   │
│   ├── services
│   │   ├── API_services.dart
│   │
│   ├── styles
│   │   ├── styles.dart
│   │
│   ├── widgets
│   │   ├── widgets.dart
│   │
│   ├── main.dart
```
# blocs
> 在 blocs 負責作為與UI跟資料間的橋梁
> 若UI需要資料則會將 bloc內的dart檔案呼叫 拉資料
> (可以自己建立需要的檔案)
# models
> 不論是有模型都放這 如呼叫API需要的物件 或是接收API需要的物件
> (按照需求自己建立需要的檔案)
# screens
> 這就是每頁的檔案位置 僅建置UI部分(按照自己需求建立檔案)
# services
> 即為呼叫API的地方(依照自己需求建立檔案)
# styles
> 當有共同需要用到的style時放置位置(如顏色之類的)(按照自己需求建立檔案)
# widgets
> 當有共同需要用到的widget時放置位置 尤其當這個widget可以重複使用時(按照自己需求建立檔案)

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
