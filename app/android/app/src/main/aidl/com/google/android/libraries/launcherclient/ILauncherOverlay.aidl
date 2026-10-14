// The interface a launcher calls on the app that draws its leftmost "minus one" page.
//
// Google never published this as an SDK API: it is the private contract between a Launcher3
// derivative and the Google app. The declaration below is the same one Lawnchair ships
// (lawnchair/aidl/com/google/android/libraries/launcherclient/, Apache-2.0), reproduced
// unchanged because the method ORDER fixes the Binder transaction codes - reordering or
// inserting a method here would make every call land on the wrong one.
//
// Loupe implements it in MinusOneOverlayService.kt; the package and interface name have to
// stay exactly as they are, because the launcher looks the interface up by its descriptor
// string "com.google.android.libraries.launcherclient.ILauncherOverlay".
package com.google.android.libraries.launcherclient;

import android.view.WindowManager.LayoutParams;
import com.google.android.libraries.launcherclient.ILauncherOverlayCallback;

interface ILauncherOverlay {

    oneway void startScroll();

    oneway void onScroll(in float progress);

    oneway void endScroll();

    oneway void windowAttached(in LayoutParams lp, in ILauncherOverlayCallback cb, in int flags);

    oneway void windowDetached(in boolean isChangingConfigurations);

    oneway void closeOverlay(in int flags);

    oneway void onPause();

    oneway void onResume();

    oneway void openOverlay(in int flags);

    oneway void requestVoiceDetection(in boolean start);

    String getVoiceSearchLanguage();

    boolean isVoiceDetectionRunning();

    boolean hasOverlayContent();

    oneway void windowAttached2(in Bundle bundle, in ILauncherOverlayCallback cb);

    oneway void unusedMethod();

    oneway void setActivityState(in int flags);

    boolean startSearch(in byte[] data, in Bundle bundle);

}
