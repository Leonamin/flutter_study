# Flutter 파이어베이스 인증 프로젝트
## 트러블 슈팅
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

### 3. flutter 빌드
1. 실제 기기 업로드 에러
- dex 64K 어쩌고가 나왔다
    - app 모듈 아래 build.gradle에 `multiDexEnabled true` 설정
- build failed for task ':app:mergeDebugResources'
    - flutter clean 실행 후 pubspec.yaml 다시 로드후 해결
- Failed to apply plugin 'com.android.internal.application'.
    - 그래들 버전 때문에 별수없다 JDK 11 설치하자
### 4. Facebook 개발자 페이지 설정
1. 개발 및 릴리스 키 해시 추가 관련
- Windows에서 아래 명령어를 입력하는건데
```
keytool -exportcert -alias androiddebugkey -keystore "C:\Users\USERNAME\.android\debug.keystore" | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" sha1 -binary | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" base64   
```
USERNAME: 유저 네임 설정하자
PATH_TO_OPENSSL_LIBRARY: openssl 다운로드 받고 알아서 잘 경로 설치하면 된다. C바로 아래에 openssl 폴더 만들어서 거기에 넣었다.
그리고 powershell에서는 자꾸 파이프라인 관련 에러만 나오면서 안될건데 cmd로 실행하면 바로 된다.