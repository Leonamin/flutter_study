# Flutter 파이어베이스 인증 프로젝트
## 기록
### 1. keytool 설정 문제
디버그용 키를 생성할 때에는 아래와 같은 명령어를 사용하는데
```
keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore
```
해당 명령어를 사용하면 `keytool 오류: java.lang.Exception: 키 저장소 파일이 존재하지 않음: %USERPROFILE%\.android\debug.keystore` 이런 오류가 발생한다. 
그래서 그냥 쌩으로 `%USERPROFILE%` 부분을 내 유저폴더 경로로 바꿨다.

+ keytool의 기본 비밀번호는 android다

### 2. flutter 설정
1. firebase-cli를 설치한다
그냥 .exe를 다운받으면 환경변수 설정이라던가 귀찮아서 node.js 설치하고 npm으로 설치했다.
2. dart pub global activate flutterfire_cli 이거를 한다
분명 Pub installs executables into C:\Users\lsmn0\AppData\Local\Pub\Cache\bin, which is not on your path. 오류가 난다
그래서 flutterfire 명령어가 안될것이다. 환경변수 들어가서 path 설정을 해주자
3. flutterfire configure --project=test-sns-login-d401e 실행한다.
4. 끗