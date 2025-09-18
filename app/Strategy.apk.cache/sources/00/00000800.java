package org.godotengine.godot.utils;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PermissionInfo;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.util.Log;
import androidx.core.content.ContextCompat;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/* loaded from: classes2.dex */
public final class PermissionsUtil {
    public static final int REQUEST_ALL_PERMISSION_REQ_CODE = 1001;
    static final int REQUEST_CAMERA_PERMISSION = 2;
    public static final int REQUEST_MANAGE_EXTERNAL_STORAGE_REQ_CODE = 2002;
    static final int REQUEST_RECORD_AUDIO_PERMISSION = 1;
    public static final int REQUEST_SINGLE_PERMISSION_REQ_CODE = 1002;
    static final int REQUEST_VIBRATE_PERMISSION = 3;
    private static final String TAG = PermissionsUtil.class.getSimpleName();

    private PermissionsUtil() {
    }

    public static boolean requestPermission(String permissionName, Activity activity) {
        if (Build.VERSION.SDK_INT < 23) {
            return true;
        }
        char c = 65535;
        switch (permissionName.hashCode()) {
            case 463403621:
                if (permissionName.equals("android.permission.CAMERA")) {
                    c = 3;
                    break;
                }
                break;
            case 1107437128:
                if (permissionName.equals("RECORD_AUDIO")) {
                    c = 0;
                    break;
                }
                break;
            case 1169293647:
                if (permissionName.equals("VIBRATE")) {
                    c = 4;
                    break;
                }
                break;
            case 1382557199:
                if (permissionName.equals("android.permission.VIBRATE")) {
                    c = 5;
                    break;
                }
                break;
            case 1831139720:
                if (permissionName.equals("android.permission.RECORD_AUDIO")) {
                    c = 1;
                    break;
                }
                break;
            case 1980544805:
                if (permissionName.equals("CAMERA")) {
                    c = 2;
                    break;
                }
                break;
        }
        switch (c) {
            case 0:
            case 1:
                if (ContextCompat.checkSelfPermission(activity, "android.permission.RECORD_AUDIO") != 0) {
                    activity.requestPermissions(new String[]{"android.permission.RECORD_AUDIO"}, 1);
                    return false;
                }
                return true;
            case 2:
            case 3:
                if (ContextCompat.checkSelfPermission(activity, "android.permission.CAMERA") != 0) {
                    activity.requestPermissions(new String[]{"android.permission.CAMERA"}, 2);
                    return false;
                }
                return true;
            case 4:
            case 5:
                if (ContextCompat.checkSelfPermission(activity, "android.permission.VIBRATE") != 0) {
                    activity.requestPermissions(new String[]{"android.permission.VIBRATE"}, 3);
                    return false;
                }
                return true;
            default:
                try {
                    PermissionInfo permissionInfo = getPermissionInfo(activity, permissionName);
                    int protectionLevel = Build.VERSION.SDK_INT >= 28 ? permissionInfo.getProtection() : permissionInfo.protectionLevel;
                    if (protectionLevel != 1 || ContextCompat.checkSelfPermission(activity, permissionName) == 0) {
                        return true;
                    }
                    activity.requestPermissions(new String[]{permissionName}, 1002);
                    return false;
                } catch (PackageManager.NameNotFoundException e) {
                    String str = TAG;
                    Log.w(str, "Unable to identify permission " + permissionName, e);
                    return false;
                }
        }
    }

    public static boolean requestManifestPermissions(Activity activity) {
        return requestManifestPermissions(activity, null);
    }

    public static boolean requestManifestPermissions(Activity activity, Set<String> excludes) {
        if (Build.VERSION.SDK_INT < 23) {
            return true;
        }
        try {
            String[] manifestPermissions = getManifestPermissions(activity);
            if (manifestPermissions.length == 0) {
                return true;
            }
            List<String> requestedPermissions = new ArrayList<>();
            for (String manifestPermission : manifestPermissions) {
                if (excludes == null || !excludes.contains(manifestPermission)) {
                    try {
                        if (manifestPermission.equals("android.permission.MANAGE_EXTERNAL_STORAGE")) {
                            if (Build.VERSION.SDK_INT >= 30 && !Environment.isExternalStorageManager()) {
                                try {
                                    Intent intent = new Intent("android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
                                    intent.setData(Uri.parse(String.format("package:%s", activity.getPackageName())));
                                    activity.startActivityForResult(intent, REQUEST_MANAGE_EXTERNAL_STORAGE_REQ_CODE);
                                } catch (Exception e) {
                                    activity.startActivityForResult(new Intent("android.settings.MANAGE_ALL_FILES_ACCESS_PERMISSION"), REQUEST_MANAGE_EXTERNAL_STORAGE_REQ_CODE);
                                }
                            }
                        } else {
                            PermissionInfo permissionInfo = getPermissionInfo(activity, manifestPermission);
                            int protectionLevel = Build.VERSION.SDK_INT >= 28 ? permissionInfo.getProtection() : permissionInfo.protectionLevel;
                            if (protectionLevel == 1 && ContextCompat.checkSelfPermission(activity, manifestPermission) != 0) {
                                requestedPermissions.add(manifestPermission);
                            }
                        }
                    } catch (PackageManager.NameNotFoundException e2) {
                        Log.w(TAG, "Unable to identify permission " + manifestPermission, e2);
                    }
                }
            }
            if (requestedPermissions.isEmpty()) {
                return true;
            }
            activity.requestPermissions((String[]) requestedPermissions.toArray(new String[0]), 1001);
            return false;
        } catch (PackageManager.NameNotFoundException e3) {
            e3.printStackTrace();
            return false;
        }
    }

    public static String[] getGrantedPermissions(Activity activity) {
        try {
            String[] manifestPermissions = getManifestPermissions(activity);
            if (manifestPermissions.length == 0) {
                return manifestPermissions;
            }
            List<String> grantedPermissions = new ArrayList<>();
            for (String manifestPermission : manifestPermissions) {
                try {
                    if (manifestPermission.equals("android.permission.MANAGE_EXTERNAL_STORAGE")) {
                        if (Build.VERSION.SDK_INT >= 30 && Environment.isExternalStorageManager()) {
                            grantedPermissions.add(manifestPermission);
                        }
                    } else {
                        PermissionInfo permissionInfo = getPermissionInfo(activity, manifestPermission);
                        int protectionLevel = Build.VERSION.SDK_INT >= 28 ? permissionInfo.getProtection() : permissionInfo.protectionLevel;
                        if (protectionLevel == 1 && ContextCompat.checkSelfPermission(activity, manifestPermission) == 0) {
                            grantedPermissions.add(manifestPermission);
                        }
                    }
                } catch (PackageManager.NameNotFoundException e) {
                    Log.w(TAG, "Unable to identify permission " + manifestPermission, e);
                }
            }
            return (String[]) grantedPermissions.toArray(new String[0]);
        } catch (PackageManager.NameNotFoundException e2) {
            e2.printStackTrace();
            return new String[0];
        }
    }

    public static boolean hasManifestPermission(Activity activity, String permission) {
        String[] manifestPermissions;
        try {
            for (String p : getManifestPermissions(activity)) {
                if (permission.equals(p)) {
                    return true;
                }
            }
        } catch (PackageManager.NameNotFoundException e) {
        }
        return false;
    }

    private static String[] getManifestPermissions(Activity activity) throws PackageManager.NameNotFoundException {
        PackageManager packageManager = activity.getPackageManager();
        PackageInfo packageInfo = packageManager.getPackageInfo(activity.getPackageName(), 4096);
        if (packageInfo.requestedPermissions == null) {
            return new String[0];
        }
        return packageInfo.requestedPermissions;
    }

    private static PermissionInfo getPermissionInfo(Activity activity, String permission) throws PackageManager.NameNotFoundException {
        PackageManager packageManager = activity.getPackageManager();
        return packageManager.getPermissionInfo(permission, 0);
    }
}