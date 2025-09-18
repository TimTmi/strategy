package org.godotengine.godot;

import android.app.Activity;
import android.content.res.AssetManager;
import android.view.Surface;
import org.godotengine.godot.io.directory.DirectoryAccessHandler;
import org.godotengine.godot.io.file.FileAccessHandler;
import org.godotengine.godot.tts.GodotTTS;
import org.godotengine.godot.utils.GodotNetUtils;

/* loaded from: classes2.dex */
public class GodotLib {
    public static native void accelerometer(float f, float f2, float f3);

    public static native void back();

    public static native void calldeferred(long j, String str, Object[] objArr);

    public static native void callobject(long j, String str, Object[] objArr);

    public static native void dispatchMouseEvent(int i, int i2, float f, float f2, float f3, float f4, boolean z, boolean z2);

    public static native void dispatchTouchEvent(int i, int i2, int i3, float[] fArr, boolean z);

    public static native void focusin();

    public static native void focusout();

    public static native String getEditorSetting(String str);

    public static native String getGlobal(String str);

    public static native void gravity(float f, float f2, float f3);

    public static native void gyroscope(float f, float f2, float f3);

    public static native boolean initialize(Activity activity, Godot godot, AssetManager assetManager, GodotIO godotIO, GodotNetUtils godotNetUtils, DirectoryAccessHandler directoryAccessHandler, FileAccessHandler fileAccessHandler, boolean z);

    public static native void joyaxis(int i, int i2, float f);

    public static native void joybutton(int i, int i2, boolean z);

    public static native void joyconnectionchanged(int i, boolean z, String str);

    public static native void joyhat(int i, int i2, int i3);

    public static native void key(int i, int i2, int i3, boolean z);

    public static native void magnetometer(float f, float f2, float f3);

    public static native void magnify(float f, float f2, float f3);

    public static native void newcontext(Surface surface);

    public static native void onRendererPaused();

    public static native void onRendererResumed();

    public static native void ondestroy();

    public static native void pan(float f, float f2, float f3, float f4);

    public static native void requestPermissionResult(String str, boolean z);

    public static native void resize(Surface surface, int i, int i2);

    public static native void setVirtualKeyboardHeight(int i);

    public static native boolean setup(String[] strArr, GodotTTS godotTTS);

    public static native boolean step();

    public static native void ttsCallback(int i, int i2, int i3);

    static {
        System.loadLibrary("godot_android");
    }
}