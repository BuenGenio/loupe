// What the launcher hands us in windowAttached2, so the panel can report back: how far it has
// slid in (the launcher moves its workspace to match), and whether it is there at all.
//
// Reproduced unchanged from Lawnchair, for the reasons in ILauncherOverlay.aidl.
package com.google.android.libraries.launcherclient;

interface ILauncherOverlayCallback {

    oneway void overlayScrollChanged(float progress);

    oneway void overlayStatusChanged(int status);

}
