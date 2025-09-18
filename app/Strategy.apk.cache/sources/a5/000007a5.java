package org.godotengine.godot;

import android.view.SurfaceView;
import org.godotengine.godot.input.GodotInputHandler;

/* loaded from: classes2.dex */
public interface GodotRenderView {
    boolean canCapturePointer();

    void configurePointerIcon(int i, String str, float f, float f2);

    GodotInputHandler getInputHandler();

    SurfaceView getView();

    void initInputDevices();

    void onActivityPaused();

    void onActivityResumed();

    void onBackPressed();

    void queueOnRenderThread(Runnable runnable);

    void setPointerIcon(int i);

    /* renamed from: org.godotengine.godot.GodotRenderView$-CC  reason: invalid class name */
    /* loaded from: classes2.dex */
    public final /* synthetic */ class CC {
    }
}