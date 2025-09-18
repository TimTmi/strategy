package org.godotengine.godot.input;

import android.content.Context;
import android.hardware.input.InputManager;
import android.os.Build;
import android.util.Log;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.view.GestureDetector;
import android.view.InputDevice;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import androidx.core.view.InputDeviceCompat;
import androidx.core.view.MotionEventCompat;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import org.godotengine.godot.GodotLib;
import org.godotengine.godot.GodotRenderView;

/* loaded from: classes2.dex */
public class GodotInputHandler implements InputManager.InputDeviceListener {
    private static final String TAG = GodotInputHandler.class.getSimpleName();
    private final GestureDetector gestureDetector;
    private final GodotGestureHandler godotGestureHandler;
    private final InputManager mInputManager;
    private final GodotRenderView mRenderView;
    private final ScaleGestureDetector scaleGestureDetector;
    private final SparseIntArray mJoystickIds = new SparseIntArray(4);
    private final SparseArray<Joystick> mJoysticksDevices = new SparseArray<>(4);
    private int lastSeenToolType = 0;

    public GodotInputHandler(GodotRenderView godotView) {
        Context context = godotView.getView().getContext();
        this.mRenderView = godotView;
        InputManager inputManager = (InputManager) context.getSystemService("input");
        this.mInputManager = inputManager;
        inputManager.registerInputDeviceListener(this, null);
        GodotGestureHandler godotGestureHandler = new GodotGestureHandler();
        this.godotGestureHandler = godotGestureHandler;
        GestureDetector gestureDetector = new GestureDetector(context, godotGestureHandler);
        this.gestureDetector = gestureDetector;
        gestureDetector.setIsLongpressEnabled(false);
        ScaleGestureDetector scaleGestureDetector = new ScaleGestureDetector(context, godotGestureHandler);
        this.scaleGestureDetector = scaleGestureDetector;
        if (Build.VERSION.SDK_INT >= 23) {
            scaleGestureDetector.setStylusScaleEnabled(true);
        }
    }

    public void enableLongPress(boolean enable) {
        this.gestureDetector.setIsLongpressEnabled(enable);
    }

    public void enablePanningAndScalingGestures(boolean enable) {
        this.godotGestureHandler.setPanningAndScalingEnabled(enable);
    }

    private boolean isKeyEventGameDevice(int source) {
        if (source == 769) {
            return false;
        }
        return (source & InputDeviceCompat.SOURCE_JOYSTICK) == 16777232 || (source & InputDeviceCompat.SOURCE_DPAD) == 513 || (source & InputDeviceCompat.SOURCE_GAMEPAD) == 1025;
    }

    public boolean canCapturePointer() {
        return this.lastSeenToolType == 3;
    }

    public void onPointerCaptureChange(boolean hasCapture) {
        this.godotGestureHandler.onPointerCaptureChange(hasCapture);
    }

    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (keyCode == 4) {
            return true;
        }
        if (keyCode == 24 || keyCode == 25) {
            return false;
        }
        int source = event.getSource();
        if (isKeyEventGameDevice(source)) {
            int deviceId = event.getDeviceId();
            if (this.mJoystickIds.indexOfKey(deviceId) >= 0) {
                int button = getGodotButton(keyCode);
                int godotJoyId = this.mJoystickIds.get(deviceId);
                GodotLib.joybutton(godotJoyId, button, false);
            }
        } else {
            int physical_keycode = event.getKeyCode();
            int unicode = event.getUnicodeChar();
            int key_label = event.getDisplayLabel();
            GodotLib.key(physical_keycode, unicode, key_label, false);
        }
        return true;
    }

    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == 4) {
            this.mRenderView.onBackPressed();
            return true;
        } else if (keyCode == 24 || keyCode == 25) {
            return false;
        } else {
            int source = event.getSource();
            int deviceId = event.getDeviceId();
            if (isKeyEventGameDevice(source)) {
                if (event.getRepeatCount() <= 0 && this.mJoystickIds.indexOfKey(deviceId) >= 0) {
                    int button = getGodotButton(keyCode);
                    int godotJoyId = this.mJoystickIds.get(deviceId);
                    GodotLib.joybutton(godotJoyId, button, true);
                }
            } else {
                int physical_keycode = event.getKeyCode();
                int unicode = event.getUnicodeChar();
                int key_label = event.getDisplayLabel();
                GodotLib.key(physical_keycode, unicode, key_label, true);
            }
            return true;
        }
    }

    public boolean onTouchEvent(MotionEvent event) {
        this.lastSeenToolType = event.getToolType(0);
        this.scaleGestureDetector.onTouchEvent(event);
        if (this.gestureDetector.onTouchEvent(event) || this.godotGestureHandler.onMotionEvent(event) || event.getActionMasked() == 2) {
            return true;
        }
        if (isMouseEvent(event)) {
            return handleMouseEvent(event);
        }
        return handleTouchEvent(event);
    }

    public boolean onGenericMotionEvent(MotionEvent event) {
        this.lastSeenToolType = event.getToolType(0);
        if ((Build.VERSION.SDK_INT < 23 || !this.gestureDetector.onGenericMotionEvent(event)) && !this.godotGestureHandler.onMotionEvent(event)) {
            if (event.isFromSource(InputDeviceCompat.SOURCE_JOYSTICK) && event.getActionMasked() == 2) {
                int deviceId = event.getDeviceId();
                if (this.mJoystickIds.indexOfKey(deviceId) < 0) {
                    return false;
                }
                int godotJoyId = this.mJoystickIds.get(deviceId);
                Joystick joystick = this.mJoysticksDevices.get(deviceId);
                if (joystick == null) {
                    return true;
                }
                for (int i = 0; i < joystick.axes.size(); i++) {
                    int axis = joystick.axes.get(i).intValue();
                    float value = event.getAxisValue(axis);
                    if (joystick.axesValues.indexOfKey(axis) < 0 || joystick.axesValues.get(axis).floatValue() != value) {
                        joystick.axesValues.put(axis, Float.valueOf(value));
                        GodotLib.joyaxis(godotJoyId, i, value);
                    }
                }
                if (joystick.hasAxisHat) {
                    int hatX = Math.round(event.getAxisValue(15));
                    int hatY = Math.round(event.getAxisValue(16));
                    if (joystick.hatX != hatX || joystick.hatY != hatY) {
                        joystick.hatX = hatX;
                        joystick.hatY = hatY;
                        GodotLib.joyhat(godotJoyId, hatX, hatY);
                    }
                }
                return true;
            }
            return handleMouseEvent(event);
        }
        return true;
    }

    public void initInputDevices() {
        int[] deviceIds = this.mInputManager.getInputDeviceIds();
        for (int deviceId : deviceIds) {
            this.mInputManager.getInputDevice(deviceId);
            onInputDeviceAdded(deviceId);
        }
    }

    private int assignJoystickIdNumber(int deviceId) {
        int godotJoyId = 0;
        while (this.mJoystickIds.indexOfValue(godotJoyId) >= 0) {
            godotJoyId++;
        }
        this.mJoystickIds.put(deviceId, godotJoyId);
        return godotJoyId;
    }

    @Override // android.hardware.input.InputManager.InputDeviceListener
    public void onInputDeviceAdded(int deviceId) {
        InputDevice device;
        if (this.mJoystickIds.indexOfKey(deviceId) >= 0 || (device = this.mInputManager.getInputDevice(deviceId)) == null) {
            return;
        }
        int sources = device.getSources();
        int i = sources & InputDeviceCompat.SOURCE_GAMEPAD;
        int i2 = InputDeviceCompat.SOURCE_JOYSTICK;
        if (i != 1025 && (sources & InputDeviceCompat.SOURCE_JOYSTICK) != 16777232) {
            return;
        }
        int id = assignJoystickIdNumber(deviceId);
        Joystick joystick = new Joystick();
        joystick.device_id = deviceId;
        joystick.name = device.getName();
        String str = TAG;
        Log.i(str, "=== New Input Device: " + joystick.name);
        Set<Integer> already = new HashSet<>();
        for (InputDevice.MotionRange range : device.getMotionRanges()) {
            boolean isJoystick = range.isFromSource(i2);
            boolean isGamepad = range.isFromSource(InputDeviceCompat.SOURCE_GAMEPAD);
            if (isJoystick || isGamepad) {
                int axis = range.getAxis();
                if (axis == 15 || axis == 16) {
                    joystick.hasAxisHat = true;
                } else if (!already.contains(Integer.valueOf(axis))) {
                    already.add(Integer.valueOf(axis));
                    joystick.axes.add(Integer.valueOf(axis));
                } else {
                    String str2 = TAG;
                    Log.w(str2, " - DUPLICATE AXIS VALUE IN LIST: " + axis);
                }
                i2 = InputDeviceCompat.SOURCE_JOYSTICK;
            }
        }
        Collections.sort(joystick.axes);
        for (int idx = 0; idx < joystick.axes.size(); idx++) {
            String str3 = TAG;
            Log.i(str3, " - Mapping Android axis " + joystick.axes.get(idx) + " to Godot axis " + idx);
        }
        this.mJoysticksDevices.put(deviceId, joystick);
        GodotLib.joyconnectionchanged(id, true, joystick.name);
    }

    @Override // android.hardware.input.InputManager.InputDeviceListener
    public void onInputDeviceRemoved(int deviceId) {
        if (this.mJoystickIds.indexOfKey(deviceId) < 0) {
            return;
        }
        int godotJoyId = this.mJoystickIds.get(deviceId);
        this.mJoystickIds.delete(deviceId);
        this.mJoysticksDevices.delete(deviceId);
        GodotLib.joyconnectionchanged(godotJoyId, false, "");
    }

    @Override // android.hardware.input.InputManager.InputDeviceListener
    public void onInputDeviceChanged(int deviceId) {
        onInputDeviceRemoved(deviceId);
        onInputDeviceAdded(deviceId);
    }

    public static int getGodotButton(int keyCode) {
        switch (keyCode) {
            case 19:
                return 11;
            case MotionEventCompat.AXIS_RUDDER /* 20 */:
                return 12;
            case MotionEventCompat.AXIS_WHEEL /* 21 */:
                return 13;
            case MotionEventCompat.AXIS_GAS /* 22 */:
                return 14;
            case 96:
                return 0;
            case 97:
                return 1;
            case 98:
                return 17;
            case 99:
                return 2;
            case 100:
                return 3;
            case 101:
                return 18;
            case 102:
                return 9;
            case 103:
                return 10;
            case 104:
                return 15;
            case 105:
                return 16;
            case 106:
                return 7;
            case 107:
                return 8;
            case 108:
                return 6;
            case 109:
                return 4;
            default:
                int button = (keyCode - 188) + 20;
                return button;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean isMouseEvent(MotionEvent event) {
        return isMouseEvent(event.getSource());
    }

    private static boolean isMouseEvent(int eventSource) {
        boolean z = false;
        boolean mouseSource = (eventSource & 8194) == 8194 || (eventSource & 20482) == 16386;
        if (Build.VERSION.SDK_INT >= 26) {
            return (mouseSource || (eventSource & 131076) == 131076) ? true : true;
        }
        return mouseSource;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean handleMotionEvent(MotionEvent event) {
        if (isMouseEvent(event)) {
            return handleMouseEvent(event);
        }
        return handleTouchEvent(event);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean handleMotionEvent(int eventSource, int eventAction, int buttonsMask, float x, float y) {
        return handleMotionEvent(eventSource, eventAction, buttonsMask, x, y, false);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean handleMotionEvent(int eventSource, int eventAction, int buttonsMask, float x, float y, boolean doubleTap) {
        return handleMotionEvent(eventSource, eventAction, buttonsMask, x, y, 0.0f, 0.0f, doubleTap);
    }

    static boolean handleMotionEvent(int eventSource, int eventAction, int buttonsMask, float x, float y, float deltaX, float deltaY, boolean doubleTap) {
        return isMouseEvent(eventSource) ? handleMouseEvent(eventAction, buttonsMask, x, y, deltaX, deltaY, doubleTap, false) : handleTouchEvent(eventAction, x, y, doubleTap);
    }

    static boolean handleMouseEvent(MotionEvent event) {
        boolean sourceMouseRelative;
        int eventAction = event.getActionMasked();
        float x = event.getX();
        float y = event.getY();
        int buttonsMask = event.getButtonState();
        float verticalFactor = event.getAxisValue(9);
        float horizontalFactor = event.getAxisValue(10);
        if (Build.VERSION.SDK_INT < 26) {
            sourceMouseRelative = false;
        } else {
            boolean sourceMouseRelative2 = event.isFromSource(131076);
            sourceMouseRelative = sourceMouseRelative2;
        }
        return handleMouseEvent(eventAction, buttonsMask, x, y, horizontalFactor, verticalFactor, false, sourceMouseRelative);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean handleMouseEvent(int eventAction, int buttonsMask, float x, float y) {
        return handleMouseEvent(eventAction, buttonsMask, x, y, 0.0f, 0.0f, false, false);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean handleMouseEvent(int eventAction, int buttonsMask, float x, float y, float deltaX, float deltaY, boolean doubleClick, boolean sourceMouseRelative) {
        switch (eventAction) {
            case 0:
            case 2:
                if (buttonsMask == 0) {
                    buttonsMask = 1;
                    break;
                }
                break;
            case 1:
            case 3:
                buttonsMask = 0;
                break;
        }
        switch (eventAction) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 7:
            case 8:
            case 9:
            case 10:
                GodotLib.dispatchMouseEvent(eventAction, buttonsMask, x, y, deltaX, deltaY, doubleClick, sourceMouseRelative);
                return true;
            case 4:
            case 5:
            case 6:
            default:
                return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean handleTouchEvent(MotionEvent event) {
        int pointerCount = event.getPointerCount();
        if (pointerCount == 0) {
            return true;
        }
        float[] positions = new float[pointerCount * 3];
        for (int i = 0; i < pointerCount; i++) {
            positions[(i * 3) + 0] = event.getPointerId(i);
            positions[(i * 3) + 1] = event.getX(i);
            positions[(i * 3) + 2] = event.getY(i);
        }
        int action = event.getActionMasked();
        int actionPointerId = event.getPointerId(event.getActionIndex());
        return handleTouchEvent(action, actionPointerId, pointerCount, positions, false);
    }

    static boolean handleTouchEvent(int eventAction, float x, float y, boolean doubleTap) {
        return handleTouchEvent(eventAction, 0, 1, new float[]{0.0f, x, y}, doubleTap);
    }

    static boolean handleTouchEvent(int eventAction, int actionPointerId, int pointerCount, float[] positions, boolean doubleTap) {
        switch (eventAction) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 5:
            case 6:
                GodotLib.dispatchTouchEvent(eventAction, actionPointerId, pointerCount, positions, doubleTap);
                return true;
            case 4:
            default:
                return false;
        }
    }
}