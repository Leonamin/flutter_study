# 로그인/회원가입 화면 구성 따라하기
https://www.youtube.com/watch?v=PpekJXY04fM.

## 하면서 배운거
1. MaterialApp의 ThemeData
지금까지 Stateless Widget에 따로따로 두거나 개별 위젯에 하드코딩을 해놨는데 ThemeData를 사용하면 공통적인 부분에 대해서는 디자인 가이드라인을 세울 수 있다.  
- theme, darkTheme
스마트폰 테마 설정에 따라서 라이트 모드 다크 모드에 사용할 테마를 지정한다.
- brightness는 앱의 전반적인 밝기에 영향을 준다(근데 배경이 검은색이라 그런가 별 차이가 안보인다.)
- textTheme은 headline, label 등 각 위젯들의 기본 TextStyle을 지정할 수 있게한다.
2018 버전과 2021 버전이 있으며 둘을 섞어 사용할 수 없다.  
이 외에도 다양한 속성이 있으니 문서 보고 적절히 참고하면 되겠다.

2. Text
Text, RichText, TextSpan을 좀더 정확하게 알게되었다.  
- Text는 가장 단순하게 화면에 텍스트를 그려준다.
- TextStyle은 Text 위젯들에 스타일을 지정한다.
- RichText, Text.rich()는 텍스트 마다 다양한 스타일을 구성할 때 사용하고 TextSpan()을 자식 개체로 사용한다.
RichText -> TextSpan -> List[TextSpan....] 이렇게 구성된다.
- TextSpan 하나의 문자열이라고 보면 편하다.
TextSpan은 최종적으로 가장 위의 개체를 기준으로 해서 하나의 문단이 된다.

3. FittedBox
자식 위젯에 맞춰 알아서 줄이는 위젯  
나는 지금까지 이 위젯의 존재를 몰라서 헛고생하고 살았다.  
fit 속성의 BoxFit()을 따라서 지정되므로 자세한건 여기서 보자  
https://api.flutter.dev/flutter/painting/BoxFit.html

4. Spacer
Flex 컨테이너(예 Row, Column,)에서 위젯 사이의 공간을 알아서 채워주는 매우 고마운 위젯