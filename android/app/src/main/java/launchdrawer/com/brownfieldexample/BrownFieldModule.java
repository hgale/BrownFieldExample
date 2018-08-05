package launchdrawer.com.brownfieldexample;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;

public class BrownFieldModule extends ReactContextBaseJavaModule {

    public BrownFieldModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "BrownFieldExample";
    }
}
