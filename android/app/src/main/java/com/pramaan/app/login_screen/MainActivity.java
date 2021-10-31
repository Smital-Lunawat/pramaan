package com.pramaan.app;
// import android.os.Bundle;
// import io.flutter.plugin.common.MethodCall;
// import io.flutter.embedding.android.FlutterActivity;
// import io.flutter.embedding.engine.FlutterEngine;
// import io.flutter.plugin.common.MethodChannel;
// import io.flutter.plugins.GeneratedPluginRegistrant;
// import android.content.Intent;
// import androidx.annotation.NonNull;
// public class MainActivity extends FlutterActivity {
//     private static final String CHANNEL = "openAUA";
//     @Override
//     public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine){
//         GeneratedPluginRegistrant.registerWith(flutterEngine);

//         new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler((call, result)->{
//             if(call.method.equals("openAUA")){
//                 openAUA();
//             }
//         });
//     }
//     public void openAUA() {
//         Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
//         startActivity(intent);
//     }
// }

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String INTENT_ACTION =
            "in.gov.uidai.rdservice.face.STATELESS_MATCH";

    private static MethodChannel.Result result;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), "com.pramaan").setMethodCallHandler(callHandler);
    }

    private MethodChannel.MethodCallHandler callHandler = new MethodChannel.MethodCallHandler() {

        @Override
        public void onMethodCall(MethodCall methodCall,
                                 MethodChannel.Result result) {
            String ekyc = methodCall.argument("ekyc");
            MainActivity.result = result;
            openAUA(ekyc);
        }
    };
    @SuppressLint("NewApi")
    private void openAUA(String ekyc){
        Intent sendIntent = new Intent();
        sendIntent.setAction(INTENT_ACTION);
        Bundle bundle = new Bundle();
        //ekyc contains the entire xml

        StatelessMatchRequest statelessMatchRequest = new StatelessMatchRequest();
        statelessMatchRequest.requestId ="850b962e041c11e192340123456789ab";
        statelessMatchRequest.signedDocument = ekyc;
        statelessMatchRequest.language = "en";
        statelessMatchRequest.enableAutoCapture = "true";


        try {
            sendIntent.putExtra("request",statelessMatchRequest.toXml());
            if (sendIntent.resolveActivity(getPackageManager()) != null) {
                startActivityForResult(sendIntent, 123);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void onActivityResult(int req, int res, Intent data) {
        if (req == 123) {
            if (res == Activity.RESULT_OK) {
           // handle the your response here
                // result.success(username);
            }
        } else {
            super.onActivityResult(req, res, data);
        }
    }
}