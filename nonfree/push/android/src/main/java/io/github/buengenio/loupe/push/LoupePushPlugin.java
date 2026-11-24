package io.github.buengenio.loupe.push;

import io.flutter.embedding.engine.plugins.FlutterPlugin;

/**
 * NonFree push has no Android code: this module only brings Firebase's
 * settings and manifest entries into the app. Flutter registers a plugin
 * class for every Android module, so here is one that does nothing.
 */
public final class LoupePushPlugin implements FlutterPlugin {
    @Override
    public void onAttachedToEngine(FlutterPluginBinding binding) {}

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {}
}
