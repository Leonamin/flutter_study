# 안드로이드 백그라운드 실행
https://medium.com/p/2b3e40a1a124#1b99  
Background execution: Android (Kotlin) 문단 번역  
## 소개
안드로이드에서 플러그인의 구현을 하려면 아래 3가지의 클래스들이 필요하다.  

- GeofencingPlugin 클래스는 다트 코드에서 만들어진 메소드 요청을 받고 다루기 위해 플러터 엔진에 등록된다.
- GeofencingBroadcastReceiver는 지오펜스 이벤트가 발생하면 시스템이 리시버를 호출한다.
- GeofencingService는 백그라운드 isolate를 생성하고 콜백 디스패쳐를 초기화하고 콜백 디스패쳐를 호출하기 전에 지오펜스 이벤트를 처리한다.  

일반적으로 플러그인, 브로드캐스트리시버, 서비스는 안드로이드에서 플러그인에대한 일반적인 패턴이다.
## GeofencingPlugin
GeofencingPlugin의 주목적은 다트코드에서 요청들을 처리하고 요청에 따라 지오펜스 이벤트를 등록하거나 삭제한다.  
이 클래스의 인스턴스는 어플리케이션 실행시 자동으로 생성되고 플러그인 레지스트리에 추가된다.  
이 클래스는 플러그인의 기본 기능에 필요한 아래의 두 가지 인터페이스를 구현한다.
- FlutterPlugin: onAttachedToEngine과 onDetachedFromEngine에서 선언되고 플러터 엔진 인스턴스로 플러그인의 연결상태를 알리기위해 사용한다.
- MethodCallHandler: onMethodCall에서 선언되고 MethodChannel에서 플러그인에게 들어온 메세지를 처리한다.  

대부분 플러그인들은 FlutterPlugin과 MethodCallHandler를 구현하면되지만 어떤 플러그인들은 현재 Activity에 대한 정보나 기타 어플리케이션 컴포넌트가 필요할 때도 있다.  
플러그인의 인스턴스에 현재 연결된 어플리케이션 구성 요소에 접근하려면 플러그인은 Activity, BroadcastReceiver, ContentProvider 혹은 Service에 대한 하나 이상의 'awareness' 인터페이스를 구현해야한다.  
이러한 인터페이스는 컴포넌트가 연결되거나 분리될 때 플러그인에 알리기 위해 플러터 엔진에서 호출할 수 있는 콜백을 선언한다.  
예를 들어, Activity에 대한 액세스 권한이 필요한 플러그인은 ActivityAware 인터페이스를 구현하며 플러그인이 애플리케이션 최소화로 인해 Activity에 대한 액세스 권한을 얻거나 잃을 때 알림을 받는다.  

### Geofence 생성하기
요청을 처리하기 위하여 메소드 채널의 인스턴스를 가장 먼저 채널에서 생성하고 GeofencingPlugin 인스턴스를 onAttachedToEngine 구현 안에 있는 이 새로운 채널에 등록한다.

```kotlin
override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
  mContext = binding.getApplicationContext()
  mGeofencingClient = LocationServices.getGeofencingClient(mContext!!)
  val channel = MethodChannel(binding.getBinaryMessenger(), "plugins.flutter.io/geofencing_plugin")
  channel.setMethodCallHandler(this)
}
```

지오펜싱 요청들을 관리하기 위해 onMethodCall도 구현해야한다.
```kotlin
override fun onMethodCall(call: MethodCall, result: Result) {
  val args = call.arguments<ArrayList<*>>()
  when(call.method) {
    "GeofencingPlugin.initializeService" -> {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        mActivity?.requestPermissions(REQUIRED_PERMISSIONS, 12312)
      }
      // Simply stores the callback handle for the callback dispatcher
      initializeService(mContext!!, args)
      result.success(true)
    }
    "GeofencingPlugin.registerGeofence" -> registerGeofence(mContext!!,
            mGeofencingClient!!,
            args,
            result,
            true)
    "GeofencingPlugin.removeGeofence" -> removeGeofence(mContext!!,
            mGeofencingClient!!,
            args,
            result)
    else -> result.notImplemented()
  }
}
```
마지막으로 지오펜스
```kotlin
@JvmStatic
private fun getGeofencingRequest(geofence: Geofence, initialTrigger: Int): GeofencingRequest {
  return GeofencingRequest.Builder().apply {
    setInitialTrigger(initialTrigger)
    addGeofence(geofence)
  }.build()
}

@JvmStatic
private fun getGeofencePendingIndent(context: Context, callbackHandle: Long): PendingIntent {
val intent = Intent(context, GeofencingBroadcastReceiver::class.java)
        .putExtra(CALLBACK_HANDLE_KEY, callbackHandle)
return PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT)
}

// TODO(bkonyi): Reregister geofences after reboot 
// https://developer.android.com/training/location/geofencing
@JvmStatic
private fun registerGeofence(context: Context,
                              geofencingClient: GeofencingClient,
                              args: ArrayList<*>?,
                              result: Result?) {
  val callbackHandle = args!![0] as Long
  val id = args[1] as String
  val lat = args[2] as Double
  val long = args[3] as Double
  val radius = (args[4] as Number).toFloat()
  val fenceTriggers = args[5] as Int
  val initialTriggers = args[6] as Int
  val expirationDuration = (args[7] as Int).toLong()
  val loiteringDelay = args[8] as Int
  val notificationResponsiveness = args[9] as Int
  val geofence = Geofence.Builder()
          .setRequestId(id)
          .setCircularRegion(lat, long, radius)
          .setTransitionTypes(fenceTriggers)
          .setLoiteringDelay(loiteringDelay)
          .setNotificationResponsiveness(notificationResponsiveness)
          .setExpirationDuration(expirationDuration)
          .build()
  // Ensure permissions are set properly.
  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M &&
          (context.checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION)
                  == PackageManager.PERMISSION_DENIED)) {
    val msg = "'registerGeofence' requires the ACCESS_FINE_LOCATION permission."
    Log.w(TAG, msg)
    result?.error(msg, null, null)
  }
  geofencingClient.addGeofences(getGeofencingRequest(geofence, initialTriggers),
          getGeofencePendingIndent(context, callbackHandle))?.run {
    addOnSuccessListener {
      Log.i(TAG, "Successfully added geofence")
      result?.success(true)
    }
    addOnFailureListener {
      Log.e(TAG, "Failed to add geofence: $it")
      result?.error(it.toString(), null, null)
    }
  }
}
```