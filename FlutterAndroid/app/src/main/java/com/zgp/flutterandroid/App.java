package com.zgp.flutterandroid;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;

import com.hexing.libhexbase.application.HexApplication;
import com.hexing.libhexbase.cache.StringCache;

/**
 * Created by zhangguangpeng on 2018/7/30.
 */

public class App extends HexApplication {
    public static boolean isDebugMode = false;

    @Override
    public void onCreate() {
        super.onCreate();




        //DatabaseHelper.getHelper(getInstance().getContext());

    }

    /**
     * 重启app
     *
     * @param context 上下文
     * @param c       class
     */
    public void reloadApp(Context context, Class c) {
        Intent intent = new Intent(context, c);
        intent.setAction(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_LAUNCHER);
        context.startActivity(intent);
    }

    @Override
    protected void attachBaseContext(Context base) {
        //保存系统选择语言
        //super.attachBaseContext(LocaleUtil.setLocal(base));

    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        //保存系统选择语言

    }

}
