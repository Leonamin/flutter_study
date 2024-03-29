# DartGeofenceInterface
이 인터페이스는 유저에게 다음과 같은 기능을 제공한다.
- 지오펜스의 좌표와 반지름, 고유 ID, 수신할 지오펜스 이벤트 목록을 포함하는 GeofenceRegion을 생성하는 기능. 안드로이드가 iOS모다 지오펜스에 대한 설정을 좀 더 자세히 할 수 있기 때문에 안드로이드의 고유 옵션은 AndroidSettingsProperty를 통해 제공할 수 있게 만든다.
- GeofencingPlugin.registerGeofence를 사용하면 해당 영역에 대한 지오펜스 이벤트가 수신될 때 호출되는 콜백에 지오펜스 영역 인스턴스를 등록할 수 있다.
- GeofencingPlugin.removeGeofence와 GeofencingPlugin.removeGeofenceById는 추가된 이벤트로 호출되는 GeofenceRegion에 대한 등록 해제를 제공한다.  

종합하자면 이 인터페이스는 쉽고 플랫폼에 종속적이지 않아 안드로이드와 iOS 둘다 사용하기 쉽게 만들어준다.

# Dart 백그라운드 실행

## 콜백 참조하기
다트로 지오펜스에 대한 인터페이스 정의를 완료하였으니 플러그인의 세부적인 플랫폼 별로 데이터를 주고받기 위해 메소드 채널을 만든다.  

백그라운드 이벤트의 결과로 다트 콜백을 호출하려면 다트와 플랫폼 코드 사이에 전달된 핸들을 다시 가져오는 동시에 플랫폼 스레드 및 다트의 isolate를 통해 콜백을 불러올 수 있어야한다.  
```
별도 내용: PluginUtilities.getCallbackHandle에서 메서드에 대한 CallbackHandle을 다시 가져오는 것은 다이어그램에서 보듯이 Flutter엔진 내 콜백 캐시를 채우는 부작용이 있다. 이 캐시는 콜백을 가져오는데 필요한 정보를 로우한 정수 핸들에 매핑한다. 정수로 매핑된 핸들은 단순하게 콜백의 속성을 기반으로 계산된 해시이다(콜백이 가진 데이터들을 말하는것 같다). 이 캐시는 실행중에도 유지되지만 콜백 이름이 변경되거나 이동되고 PluginUtilities.getCallbackHandle이 업데이트된 콜백에 대해 호출하지 않으면 콜백 조회가 실패 할 수 있다.
```
작성한 코드 상에서는 두 개의 CallbackHandle 인스턴스를 얻게된다. 하나는 GeofenceRegion과 연결된 콜백 인스턴스이고 다른 하나는 callbackDispatcher라는 이름의 메소드를 위한 인스턴스이다. 백그라운드 isolate의 진입점인 callbackDispatcher는 raw한 지오펜스 이벤트 데이터를 전처리하고 PluginUtilities.getCallbackFromHandle을 통해 콜백을 조회하고 등록된 지오펜스에 대해 호출하는 역할을 한다.  

## Callback Dispatcher
위에서 언급되었듯이 지오펜싱 플러그인의 백그라운드 isolate에 대한 진입점을 생성하기 위해 위에서 정의한 callback dispatcher 패턴을 사용한다.  
이 패턴은 플랫폼 코드로 통신 채널을 설정하는 데 필요한 초기화를 수행하는 동시에 콜백 메소드에 대해 중요하지 않은 인터페이스를 만든다. 이 지오펜싱 플러그인의 경우 콜백 디스패처의 구현은 callback_dispatcher.dart 코드와 같다.  

코드에서 보듯 콜백 디스패처를 호출할 때(지오펜싱 플러그인의 백그라운드 isolate 생성 시) 네가지 작업만 수행한다.

첫번째로 메소드 채널은 플러그인에서 이벤트를 수신하기 위해 생성된다.  

그다음에 WidgetsFlutterBinding.ensureInitialized()은 플러터 엔진과 통신하기 위해 상태 초기화가 필요하므로 실행한다. 이 때 MethodCall 핸들러는 플러그인의 플랫폼 부분에 백그라운드 isolate가 초기화되고 이벤트 처리를 시작할 준비가 되었다는 것을 마지막으로 알리기 전에 플러그인 이벤트를 처리하도록 설정된다.

한번 플러그인이 콜백 디스패처로 이벤트를 보내기 시작하면 플러그인 사용자가 공급한 콜백을 호출할 수 있다.  
첫번째로 raw한 콜백 핸들을 사용하여 트리거된 지오펜싱 이벤트와 관련된 콜백 인스턴스를 검색하기 위해 PluginUtilities.getCallbackFromHandle가 호출된다.  
그다음 MethodCall로부터 raw 인자를 다음과 같이 가공한다.
- 트리거된 지오펜스의 ID에 대한 List<String> 인스턴스
- 기기의 현재 위치가 담겨있는 Location 인스턴스
- 트리거된 지오펜스 내에서 기기가 진입했는지 나갔는지 이동했는지 여부를 나타내는 GeofenceEvent Enum 타입의 인스턴스   
그다음 이 정보에 대한 인자들을 콜백으로 보낸다.  
```
중요한점: 사용자가 콜백 핸들러로부터 아무 상태도 유지되지 않는다고 알림을 받을 수 있다. 이는 애플리케이션 자체가 백그라운드로 실행되는 동안 백그라운드 isolate가 꺼지지않고 살아있는다는 보장이 없기 때문이다. 안드로이드와 iOS 둘다 백그라운드 서비스나 실행이 중단될 수 있는 라이프사이클 정책이 있기 때문이다. 이는 백그라운드 isolate가 종료되고 앱이 다시 실행되었을 때 생성될 수 있다는 의미이다.  
그래서 결과적으로 모범 사례는 콜백 핸들러 또는 사용자 제공 콜백에 volatile한 상태를 저장하지 않도록 하는 것이다.
```
이제 플러그인에 대해 필요한 다트 코드는 다 작성했다. 이제는 플랫폼별로 상세한 지오펜싱 플러그인을 작성할 시간이다.

## 백그라운드 실행 안드로이드편
안드로이드 플러그인 구현을 위해 아래의 두가지 클래스를 생성한다.
- 플러터 엔진에 등록되어 다트 코드로부터 만들어진 메소드 콜을 받고 다루기 위한 GeofencingPlugin 클래스
- 지오펜스 이벤트 위에서 시스템에 의해 불려질 GeofencingBroadecaseReceiver
- 백그라운드 isolate를 생성하고 콜백 디스패처를 초기화하고 콜백 디스패처를 호출하기 전에 지오펜스 이벤트를 처리할 GeofencingService  

세가지 삼위일체 플러그인 브로드캐스트 리시버 서비스 클래스가 안드로이드에서 플러그인에 대한 기본적인 패턴이다.