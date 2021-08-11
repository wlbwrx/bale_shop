package com.example.bale_shop;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    private int defaultSecond = 2;
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //倒计2s
//        handler.sendEmptyMessageDelayed(1, 1000);
    }

    @SuppressLint("HandlerLeak")
    private final Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            defaultSecond--;
            if (defaultSecond == 0) {
                //倒计时完跳进应用

            } else {
                handler.sendEmptyMessageDelayed(1, 1000);
            }
        }
    };
}
