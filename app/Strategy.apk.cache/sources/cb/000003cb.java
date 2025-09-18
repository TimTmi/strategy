package com.godot.game;

import android.os.Bundle;
import org.godotengine.godot.FullScreenGodotApp;

/* loaded from: classes4.dex */
public class GodotApp extends FullScreenGodotApp {
    @Override // org.godotengine.godot.FullScreenGodotApp, androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, androidx.core.app.ComponentActivity, android.app.Activity
    public void onCreate(Bundle savedInstanceState) {
        setTheme(R.style.GodotAppMainTheme);
        super.onCreate(savedInstanceState);
    }
}