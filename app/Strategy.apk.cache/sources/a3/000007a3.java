package org.godotengine.godot;

import android.app.Activity;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.Build;
import android.os.Environment;
import android.provider.Settings;
import android.text.TextUtils;
import android.util.Log;
import android.view.Display;
import android.view.DisplayCutout;
import android.view.WindowInsets;
import java.util.List;
import java.util.Locale;
import org.godotengine.godot.input.GodotEditText;

/* loaded from: classes2.dex */
public class GodotIO {
    public static final int SYSTEM_DIR_DCIM = 1;
    public static final int SYSTEM_DIR_DESKTOP = 0;
    public static final int SYSTEM_DIR_DOCUMENTS = 2;
    public static final int SYSTEM_DIR_DOWNLOADS = 3;
    public static final int SYSTEM_DIR_MOVIES = 4;
    public static final int SYSTEM_DIR_MUSIC = 5;
    public static final int SYSTEM_DIR_PICTURES = 6;
    public static final int SYSTEM_DIR_RINGTONES = 7;
    private static final String TAG = GodotIO.class.getSimpleName();
    private final Activity activity;
    GodotEditText edit;
    private final String uniqueId;
    final int SCREEN_LANDSCAPE = 0;
    final int SCREEN_PORTRAIT = 1;
    final int SCREEN_REVERSE_LANDSCAPE = 2;
    final int SCREEN_REVERSE_PORTRAIT = 3;
    final int SCREEN_SENSOR_LANDSCAPE = 4;
    final int SCREEN_SENSOR_PORTRAIT = 5;
    final int SCREEN_SENSOR = 6;

    /* JADX INFO: Access modifiers changed from: package-private */
    public GodotIO(Activity p_activity) {
        this.activity = p_activity;
        String androidId = Settings.Secure.getString(p_activity.getContentResolver(), "android_id");
        this.uniqueId = androidId == null ? "" : androidId;
    }

    /* JADX WARN: Removed duplicated region for block: B:16:0x0066 A[Catch: ActivityNotFoundException -> 0x0079, TryCatch #0 {ActivityNotFoundException -> 0x0079, blocks: (B:3:0x0005, B:6:0x000f, B:9:0x0016, B:14:0x0056, B:16:0x0066, B:19:0x006f, B:20:0x0072, B:17:0x006a, B:10:0x001b, B:12:0x0023, B:13:0x0028), top: B:26:0x0005 }] */
    /* JADX WARN: Removed duplicated region for block: B:17:0x006a A[Catch: ActivityNotFoundException -> 0x0079, TryCatch #0 {ActivityNotFoundException -> 0x0079, blocks: (B:3:0x0005, B:6:0x000f, B:9:0x0016, B:14:0x0056, B:16:0x0066, B:19:0x006f, B:20:0x0072, B:17:0x006a, B:10:0x001b, B:12:0x0023, B:13:0x0028), top: B:26:0x0005 }] */
    /* JADX WARN: Removed duplicated region for block: B:19:0x006f A[Catch: ActivityNotFoundException -> 0x0079, TryCatch #0 {ActivityNotFoundException -> 0x0079, blocks: (B:3:0x0005, B:6:0x000f, B:9:0x0016, B:14:0x0056, B:16:0x0066, B:19:0x006f, B:20:0x0072, B:17:0x006a, B:10:0x001b, B:12:0x0023, B:13:0x0028), top: B:26:0x0005 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    public int openURI(java.lang.String r9) {
        /*
            r8 = this;
            java.lang.String r0 = ""
            r1 = 1
            r2 = r0
            r3 = 0
            java.lang.String r4 = "/"
            boolean r4 = r9.startsWith(r4)     // Catch: android.content.ActivityNotFoundException -> L79
            java.lang.String r5 = "file://"
            if (r4 != 0) goto L1b
            boolean r4 = r9.startsWith(r5)     // Catch: android.content.ActivityNotFoundException -> L79
            if (r4 == 0) goto L16
            goto L1b
        L16:
            android.net.Uri r0 = android.net.Uri.parse(r9)     // Catch: android.content.ActivityNotFoundException -> L79
            goto L56
        L1b:
            r4 = r9
            r3 = 1
            boolean r6 = r4.startsWith(r5)     // Catch: android.content.ActivityNotFoundException -> L79
            if (r6 == 0) goto L28
            java.lang.String r0 = r4.replace(r5, r0)     // Catch: android.content.ActivityNotFoundException -> L79
            r4 = r0
        L28:
            java.io.File r0 = new java.io.File     // Catch: android.content.ActivityNotFoundException -> L79
            r0.<init>(r4)     // Catch: android.content.ActivityNotFoundException -> L79
            android.app.Activity r5 = r8.activity     // Catch: android.content.ActivityNotFoundException -> L79
            java.lang.StringBuilder r6 = new java.lang.StringBuilder     // Catch: android.content.ActivityNotFoundException -> L79
            r6.<init>()     // Catch: android.content.ActivityNotFoundException -> L79
            android.app.Activity r7 = r8.activity     // Catch: android.content.ActivityNotFoundException -> L79
            java.lang.String r7 = r7.getPackageName()     // Catch: android.content.ActivityNotFoundException -> L79
            r6.append(r7)     // Catch: android.content.ActivityNotFoundException -> L79
            java.lang.String r7 = ".fileprovider"
            r6.append(r7)     // Catch: android.content.ActivityNotFoundException -> L79
            java.lang.String r6 = r6.toString()     // Catch: android.content.ActivityNotFoundException -> L79
            android.net.Uri r5 = androidx.core.content.FileProvider.getUriForFile(r5, r6, r0)     // Catch: android.content.ActivityNotFoundException -> L79
            android.app.Activity r6 = r8.activity     // Catch: android.content.ActivityNotFoundException -> L79
            android.content.ContentResolver r6 = r6.getContentResolver()     // Catch: android.content.ActivityNotFoundException -> L79
            java.lang.String r6 = r6.getType(r5)     // Catch: android.content.ActivityNotFoundException -> L79
            r2 = r6
            r0 = r5
        L56:
            android.content.Intent r4 = new android.content.Intent     // Catch: android.content.ActivityNotFoundException -> L79
            r4.<init>()     // Catch: android.content.ActivityNotFoundException -> L79
            java.lang.String r5 = "android.intent.action.VIEW"
            r4.setAction(r5)     // Catch: android.content.ActivityNotFoundException -> L79
            boolean r5 = android.text.TextUtils.isEmpty(r2)     // Catch: android.content.ActivityNotFoundException -> L79
            if (r5 == 0) goto L6a
            r4.setData(r0)     // Catch: android.content.ActivityNotFoundException -> L79
            goto L6d
        L6a:
            r4.setDataAndType(r0, r2)     // Catch: android.content.ActivityNotFoundException -> L79
        L6d:
            if (r3 == 0) goto L72
            r4.addFlags(r1)     // Catch: android.content.ActivityNotFoundException -> L79
        L72:
            android.app.Activity r5 = r8.activity     // Catch: android.content.ActivityNotFoundException -> L79
            r5.startActivity(r4)     // Catch: android.content.ActivityNotFoundException -> L79
            r1 = 0
            return r1
        L79:
            r0 = move-exception
            java.lang.String r2 = org.godotengine.godot.GodotIO.TAG
            java.lang.StringBuilder r3 = new java.lang.StringBuilder
            r3.<init>()
            java.lang.String r4 = "Unable to open uri "
            r3.append(r4)
            r3.append(r9)
            java.lang.String r3 = r3.toString()
            android.util.Log.e(r2, r3, r0)
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: org.godotengine.godot.GodotIO.openURI(java.lang.String):int");
    }

    public String getCacheDir() {
        return this.activity.getCacheDir().getAbsolutePath();
    }

    public String getDataDir() {
        return this.activity.getFilesDir().getAbsolutePath();
    }

    public String getLocale() {
        return Locale.getDefault().toString();
    }

    public String getModel() {
        return Build.MODEL;
    }

    public int getScreenDPI() {
        return this.activity.getResources().getDisplayMetrics().densityDpi;
    }

    public float getScaledDensity() {
        int densityDpi = this.activity.getResources().getDisplayMetrics().densityDpi;
        if (densityDpi >= 640) {
            return 4.0f;
        }
        if (densityDpi >= 480) {
            return 3.0f;
        }
        if (densityDpi >= 320) {
            return 2.0f;
        }
        if (densityDpi >= 240) {
            return 1.5f;
        }
        if (densityDpi >= 160) {
            return 1.0f;
        }
        return 0.75f;
    }

    public double getScreenRefreshRate(double fallback) {
        Display display = this.activity.getWindowManager().getDefaultDisplay();
        if (display != null) {
            return display.getRefreshRate();
        }
        return fallback;
    }

    public int[] getDisplaySafeArea() {
        this.activity.getResources().getDisplayMetrics();
        Display display = this.activity.getWindowManager().getDefaultDisplay();
        Point size = new Point();
        display.getRealSize(size);
        int[] result = {0, 0, size.x, size.y};
        if (Build.VERSION.SDK_INT >= 28) {
            WindowInsets insets = this.activity.getWindow().getDecorView().getRootWindowInsets();
            DisplayCutout cutout = insets.getDisplayCutout();
            if (cutout != null) {
                int insetLeft = cutout.getSafeInsetLeft();
                int insetTop = cutout.getSafeInsetTop();
                result[0] = insetLeft;
                result[1] = insetTop;
                result[2] = result[2] - (cutout.getSafeInsetRight() + insetLeft);
                result[3] = result[3] - (cutout.getSafeInsetBottom() + insetTop);
            }
        }
        return result;
    }

    public int[] getDisplayCutouts() {
        if (Build.VERSION.SDK_INT < 28) {
            return new int[0];
        }
        DisplayCutout cutout = this.activity.getWindow().getDecorView().getRootWindowInsets().getDisplayCutout();
        if (cutout == null) {
            return new int[0];
        }
        List<Rect> rects = cutout.getBoundingRects();
        int cutouts = rects.size();
        int[] result = new int[cutouts * 4];
        int index = 0;
        for (Rect rect : rects) {
            int index2 = index + 1;
            result[index] = rect.left;
            int index3 = index2 + 1;
            result[index2] = rect.top;
            int index4 = index3 + 1;
            result[index3] = rect.width();
            index = index4 + 1;
            result[index4] = rect.height();
        }
        return result;
    }

    public void showKeyboard(String p_existing_text, int p_type, int p_max_input_length, int p_cursor_start, int p_cursor_end) {
        GodotEditText godotEditText = this.edit;
        if (godotEditText != null) {
            godotEditText.showKeyboard(p_existing_text, GodotEditText.VirtualKeyboardType.values()[p_type], p_max_input_length, p_cursor_start, p_cursor_end);
        }
    }

    public void hideKeyboard() {
        GodotEditText godotEditText = this.edit;
        if (godotEditText != null) {
            godotEditText.hideKeyboard();
        }
    }

    public void setScreenOrientation(int p_orientation) {
        switch (p_orientation) {
            case 0:
                this.activity.setRequestedOrientation(0);
                return;
            case 1:
                this.activity.setRequestedOrientation(1);
                return;
            case 2:
                this.activity.setRequestedOrientation(8);
                return;
            case 3:
                this.activity.setRequestedOrientation(9);
                return;
            case 4:
                this.activity.setRequestedOrientation(11);
                return;
            case 5:
                this.activity.setRequestedOrientation(12);
                return;
            case 6:
                this.activity.setRequestedOrientation(13);
                return;
            default:
                return;
        }
    }

    public int getScreenOrientation() {
        int orientation = this.activity.getRequestedOrientation();
        switch (orientation) {
            case 0:
                return 0;
            case 1:
                return 1;
            case 2:
            case 3:
            case 5:
            default:
                return -1;
            case 4:
            case 10:
            case 13:
                return 6;
            case 6:
            case 11:
                return 4;
            case 7:
            case 12:
                return 5;
            case 8:
                return 2;
            case 9:
                return 3;
        }
    }

    public void setEdit(GodotEditText _edit) {
        this.edit = _edit;
    }

    public String getSystemDir(int idx, boolean shared_storage) {
        String what;
        switch (idx) {
            case 1:
                what = Environment.DIRECTORY_DCIM;
                break;
            case 2:
                what = Environment.DIRECTORY_DOCUMENTS;
                break;
            case 3:
                what = Environment.DIRECTORY_DOWNLOADS;
                break;
            case 4:
                what = Environment.DIRECTORY_MOVIES;
                break;
            case 5:
                what = Environment.DIRECTORY_MUSIC;
                break;
            case 6:
                what = Environment.DIRECTORY_PICTURES;
                break;
            case 7:
                what = Environment.DIRECTORY_RINGTONES;
                break;
            default:
                what = null;
                break;
        }
        if (shared_storage) {
            if (Build.VERSION.SDK_INT >= 29) {
                Log.w(TAG, "Shared storage access is limited on Android 10 and higher.");
            }
            if (TextUtils.isEmpty(what)) {
                return Environment.getExternalStorageDirectory().getAbsolutePath();
            }
            return Environment.getExternalStoragePublicDirectory(what).getAbsolutePath();
        }
        return this.activity.getExternalFilesDir(what).getAbsolutePath();
    }

    public String getUniqueID() {
        return this.uniqueId;
    }
}