# 시계앱
https://www.youtube.com/watch?v=HyAeZKWWuxA&list=PL3wGb9_yWsvKfjFgXntI_uxUV7R0L0Act  
이걸 따라하고 있다.  
CustomPainter 사용법도 깨우치고 알람앱을 어떻게 만드나 구경해보고 나중에 프로젝트 적용하자

## 회고
최대한 수식같은 부분은 알고리즘 문제 푼다 생각하고 스스로했다.
### 1. CustomPainter와 좌표
시계를 그리면서 하나 착각하고 고생했던것은 수학 그래프 좌표랑 CustomPainter의 좌표는 다르단 것이다.

수학 그래프는 양수와 음수가 있고 항상 0,0이 중앙이지만 CustomPainter는 0,0이 왼쪽 상단이다.  

그렇기 때문에 중앙 좌표로 보정을 하려면 x좌표는 중앙 좌표를 더해야하고 y 좌표는 증가할 때 CustomPainter 상으로는 아래로 향하기 때문에 중앙좌표 - Y좌표를 해줘야 보정이 된다.   

시간의 흐름과 각도의 증가 방향은 반대이므로 시간이 흐르면 각도를 양의 증가가 아닌 음의 증가로 해주어야한다.  

또한 시초선의 방향은 3시방향이므로 이것도 90도를 더해서 보정해주는 수식을 넣어야한다.  

+ 강의 영상 해결법  
그냥 위젯 자체를 90도로 돌려버리더라.


### 2. Ticker
Flutter는 내부적으로 화면 렌더링을 위한 스케줄러를 가지고 있는데 이 스케줄러는 일반적으로 60FPS로 동작한다.  

화면의 상태가 변할 경우(예시: setState()를 쓰는 경우) UI에 변경점이 필요로 하면 다음 스케줄 프레임에 적용을 하게된다.(30 프레임에서 상태가 변하면 31프레임에서 변경을 한다는 소리겠지?)  

이때 바로 Ticker가 그 스케줄러를 가져와서 사용하는 것이다!

자세한 내용
- https://origogi.github.io/flutter/Flutter_Internals-1/
- https://codewithandrea.com/articles/flutter-timer-vs-ticker/

### 3. FittedBox
AuthScreen 예제를 할 때와 마찬가지로 덕을 좀 봤다.  

적당히 MediaQuery().of().size를 나눠서 비율 얻은다음 FittedBox에 BoxFit.fitWidth를 하면 깔끔하게 제한이 가능하다.

다만 Text의 fontSize가 지멋대로 널뛰기하는 것은 있으므로 이것도 어떻게 처리할지는 나중에 고민을 해야할 것이다.

### 4. List 타입 하위 메소드
Dart의 List는 정말 대단한 편의성을 가진 메소드가 있다.  

기본적으로 map()으로 리스트를 이용해 위젯을 만들 때 부터 잘 써왔는데 몇가지 눈여겨 볼만한 메소드가 있었다.  

- firstWhere(), lastWhere(), singleWhere()  
이전에도 몇번 써봤는데 조건을 만족하면 나오는 것들을 가져오는 메소드다.  
잘 기억이 안나는데 아마 null값이 나오기 때문에 non-null을 받아야하는 상황에서 어떤 라이브러리로 처리 했던 것이 기억난다.  

- followedBy()  
뒤에 새로운 iterable을 추가하는 메소드인데 위에 map()으로 위젯 만들 때 별도의 다른 모습의 위젯을 만드는 데에 응용할 수 있다.

### 5. BoxShadow
위젯 뒤에 그림자와 관련된 위젯이고 BoxDecoration의 boxShadow 옵션에 들어간다.
대충 써보니 아래와 같았다.
* color: 불투명할 수록 그림자도 옅어진다 
* blurRadius: 그림자 둥근거 borderRadius 값을 더해서 굴곡처리가 된다.(직각일 때 이거조차 0이면 직각이 된다.)
* spreadRadius: 말그래도 뿌려지는 범위
* offset: 블러 처리가 위젯 어디서부터 할 건지 0,0이면 골고루 x, y 바꿀수록 가로 세로 표현이 바뀐다.

### 6. DottedBorder
공식이 아닌 비공식 라이브러리 이름만 보면 border 옵션으로 넣는것처럼 보이지만 별도로 사용하는 위젯이다.  
자식을 그냥 넣으면 빈공간이 생겨서 double.infinity로 채워주거나 크기를 맞춰주거나 해야했다.

### 7. Flutter Local Notification
Flutter에서 로컬 알림 기능을 쓰게 해주는 라이브러리 AOS IOS MAC LINUX를 지원한다.  

- 설정에 대하여
설정 자체는 13.0.0 버전에서 설명에서 간소화 시켜와서 간단하다고 했다.  
눈 여겨 볼만한 설정은 언제나 그랬듯이 그래들 설정이고 app.gradle dependencies에 androidx.window~ 이거 안넣어서 에러 생겨서 다시 넣은 점이다.  
iOS는 딱히 내가 테스트 할 수 있는 환경이 아니라서 설정하지 않았지만 iOS Mac OS는 Darwin~으로 통합인거 같다.

- FlutterLocalNotificationsPlugin
일단 얘의 인스턴스를 사용해서 기능을 사용하기 때문에 main 파일에서 선언해서 때려 박아놨는데 나중에 의존성 주입으로 따로 빼면 좋을 것 같기도 하다.  
사용하기 위해서는 initialize()를 해줘야하는데 main()에서 했고 비동기 함수라서 WidgetsFlutterBinding.ensureInitialized()를 먼저 해줘야한다.  
안드로이드는 무조건 기본 아이콘을 넣어줘야하며 '@minmpa/ic_launcher'를 넣어서 res폴더의 기본 아이콘을 쓰게 했다.  

- FlutterLocalNotificationsPlugin.zonedSchedule()  
영상에서 나오는 schedule은 iOS의 타임존 문제 때문에 deprecated되고 TimeZone의 TZDateTime을 쓰는 zonedSchedule()이 새로 나왔다.  
zonedSchedule()은 아이디, 타이틀, 설명, 스케쥴 시간, 상세 플랫폼 설정, iOS 알림시간 설정, 안드로이드 슬립 모드 설정, payload, DateTimeComponets를 인자로 받는다.  
스케쥴 시간은 TZDateTime을 사용해야해서 일단 뒤로 설명한다.  
상세 플랫폼은 NotificationDetails 클래스이며 여기에 AOS Darwin Linux 설정을 넣는다.  
android는 설정이 다양했는데 거진 NotificationCompat APIs에서 웬만한거는 지원하는 것 같다.  
그중에서 눈여겨 볼만한 것은 fullScreenIntent로 대화면, 예를 들어 알람 발생시 알람 화면을 출력하는 기능이 있었다.  
다만 내가 찾아본 결과 원래 안드로이드 네이티브는 슬립모드에서는 동작을 안해서 WAKE_LOCK을 걸고 화면을 켜야하는 번거로움이 있는데 여기서도 화면을 자동으로 켜줄지는 모르겠다.  
그리고 visibility 옵션을 줘야 잠금화면에서도 제대로 출력이 될것이다.  
iOS 알림시간은 서머타임 적용 여부를 설정해줘야한다.  
androidAllowWhileIdle은 일단 low-power idle 모드에서 동작 여부를 설정하는 것인데 실제 동작이 어디까지 될지는 모르겠다.  
DateTimeCompents는 알람 시간을 정확한 날짜까지 설정할 건지 여부이다.  
그냥 설정해버리면 18일날 설정한 21일 10시 00분 알람은 19일 10시 00분에도 실행될 수 있기 때문에 달, 주, 일을 세세하게 설정할 수 있고 기본은 시분만 맞으면 실행하기로 설정한것같다.  

- TimeZone
얘를 쓰려고 좀 해맸는데 일단 TimeZone 관련 라이브러리가 그냥 쓰면 TZDateTime이 없다고 나와서 timezone/timezone.dart as tz 이런 식으로 해주고 써야 나왔었다. 
그리고 flutter_native_timezone를 사용해서 타임존을 구했는데 나중에 추가해서 그런가 flutter clean을 실행하고 다시 빌드해야 에러가 안난다.