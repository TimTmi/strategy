package org.godotengine.godot.plugin;

import java.util.Set;

/* loaded from: classes2.dex */
public interface GodotPluginInfoProvider {
    Set<String> getPluginGDExtensionLibrariesPaths();

    String getPluginName();

    Set<SignalInfo> getPluginSignals();

    void onPluginRegistered();

    /* renamed from: org.godotengine.godot.plugin.GodotPluginInfoProvider$-CC  reason: invalid class name */
    /* loaded from: classes2.dex */
    public final /* synthetic */ class CC {
        public static void $default$onPluginRegistered(GodotPluginInfoProvider _this) {
        }
    }
}