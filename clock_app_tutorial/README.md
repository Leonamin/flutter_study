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