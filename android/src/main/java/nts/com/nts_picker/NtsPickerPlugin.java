package nts.com.nts_picker;

import android.app.Activity;
import android.content.Context;
import android.src.main.java.nts.com.nts_picker.files.FilePicker;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

/**
 * NtsPickerPlugin
 */
public class NtsPickerPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context context;
    private Activity activity;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "nts_picker");
        channel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("getListFile")) {
            FilePicker filePicker = new FilePicker();
            result.success(filePicker.getListFile(context, call.argument("dir"), call.argument("type")));
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    public void onDetachedFromActivity() {
        // TODO("Not yet implemented");
    }

    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
        // TODO("Not yet implemented");
    }

    public void onAttachedToActivity(ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    public void onDetachedFromActivityForConfigChanges() {
        // TODO("Not yet implemented");
    }
}
