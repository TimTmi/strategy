package org.godotengine.godot;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import java.util.List;
import org.godotengine.godot.GodotHost;
import org.godotengine.godot.utils.ProcessPhoenix;

/* loaded from: classes2.dex */
public abstract class FullScreenGodotApp extends FragmentActivity implements GodotHost {
    protected static final String EXTRA_FORCE_QUIT = "force_quit_requested";
    protected static final String EXTRA_NEW_LAUNCH = "new_launch_requested";
    private static final String TAG = FullScreenGodotApp.class.getSimpleName();
    private Godot godotFragment;

    @Override // org.godotengine.godot.GodotHost
    public /* synthetic */ List getCommandLine() {
        return GodotHost.CC.$default$getCommandLine(this);
    }

    @Override // org.godotengine.godot.GodotHost
    public /* synthetic */ boolean onGodotForceQuit(int i) {
        return GodotHost.CC.$default$onGodotForceQuit(this, i);
    }

    @Override // org.godotengine.godot.GodotHost
    public /* synthetic */ void onGodotMainLoopStarted() {
        GodotHost.CC.$default$onGodotMainLoopStarted(this);
    }

    @Override // org.godotengine.godot.GodotHost
    public /* synthetic */ void onGodotSetupCompleted() {
        GodotHost.CC.$default$onGodotSetupCompleted(this);
    }

    @Override // org.godotengine.godot.GodotHost
    public /* synthetic */ int onNewGodotInstanceRequested(String[] strArr) {
        return GodotHost.CC.$default$onNewGodotInstanceRequested(this, strArr);
    }

    @Override // androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, androidx.core.app.ComponentActivity, android.app.Activity
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.godot_app_layout);
        handleStartIntent(getIntent(), true);
        Fragment currentFragment = getSupportFragmentManager().findFragmentById(R.id.godot_fragment_container);
        if (currentFragment instanceof Godot) {
            Log.v(TAG, "Reusing existing Godot fragment instance.");
            this.godotFragment = (Godot) currentFragment;
            return;
        }
        Log.v(TAG, "Creating new Godot fragment instance.");
        this.godotFragment = initGodotInstance();
        getSupportFragmentManager().beginTransaction().replace(R.id.godot_fragment_container, this.godotFragment).setPrimaryNavigationFragment(this.godotFragment).commitNowAllowingStateLoss();
    }

    @Override // androidx.fragment.app.FragmentActivity, android.app.Activity
    public void onDestroy() {
        Log.v(TAG, "Destroying Godot app...");
        super.onDestroy();
        m1495x86e9aa7d(this.godotFragment);
    }

    @Override // org.godotengine.godot.GodotHost
    public final void onGodotForceQuit(final Godot instance) {
        runOnUiThread(new Runnable() { // from class: org.godotengine.godot.FullScreenGodotApp$$ExternalSyntheticLambda0
            @Override // java.lang.Runnable
            public final void run() {
                FullScreenGodotApp.this.m1495x86e9aa7d(instance);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: terminateGodotInstance */
    public void m1495x86e9aa7d(Godot instance) {
        if (instance == this.godotFragment) {
            Log.v(TAG, "Force quitting Godot instance");
            ProcessPhoenix.forceQuit(this);
        }
    }

    @Override // org.godotengine.godot.GodotHost
    public final void onGodotRestartRequested(final Godot instance) {
        runOnUiThread(new Runnable() { // from class: org.godotengine.godot.FullScreenGodotApp$$ExternalSyntheticLambda1
            @Override // java.lang.Runnable
            public final void run() {
                FullScreenGodotApp.this.m1496xfbc6378d(instance);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: lambda$onGodotRestartRequested$1$org-godotengine-godot-FullScreenGodotApp  reason: not valid java name */
    public /* synthetic */ void m1496xfbc6378d(Godot instance) {
        if (instance == this.godotFragment) {
            Log.v(TAG, "Restarting Godot instance...");
            ProcessPhoenix.triggerRebirth(this);
        }
    }

    @Override // androidx.fragment.app.FragmentActivity, android.app.Activity
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        handleStartIntent(intent, false);
        Godot godot = this.godotFragment;
        if (godot != null) {
            godot.onNewIntent(intent);
        }
    }

    private void handleStartIntent(Intent intent, boolean newLaunch) {
        boolean forceQuitRequested = intent.getBooleanExtra(EXTRA_FORCE_QUIT, false);
        if (forceQuitRequested) {
            Log.d(TAG, "Force quit requested, terminating..");
            ProcessPhoenix.forceQuit(this);
        } else if (!newLaunch) {
            boolean newLaunchRequested = intent.getBooleanExtra(EXTRA_NEW_LAUNCH, false);
            if (newLaunchRequested) {
                Log.d(TAG, "New launch requested, restarting..");
                Intent restartIntent = new Intent(intent).putExtra(EXTRA_NEW_LAUNCH, false);
                ProcessPhoenix.triggerRebirth(this, restartIntent);
            }
        }
    }

    @Override // androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, android.app.Activity
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        Godot godot = this.godotFragment;
        if (godot != null) {
            godot.onActivityResult(requestCode, resultCode, data);
        }
    }

    @Override // androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, android.app.Activity
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        Godot godot = this.godotFragment;
        if (godot != null) {
            godot.onRequestPermissionsResult(requestCode, permissions, grantResults);
        }
    }

    @Override // androidx.activity.ComponentActivity, android.app.Activity
    public void onBackPressed() {
        Godot godot = this.godotFragment;
        if (godot != null) {
            godot.onBackPressed();
        } else {
            super.onBackPressed();
        }
    }

    protected Godot initGodotInstance() {
        return new Godot();
    }

    protected final Godot getGodotFragment() {
        return this.godotFragment;
    }
}