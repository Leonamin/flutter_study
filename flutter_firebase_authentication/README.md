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