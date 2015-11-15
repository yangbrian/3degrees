package me.brianyang.threedegreesandroid;

/**
 * Created by Brian on 11/14/2015.
 */

        import android.app.Activity;
        import android.content.Intent;
        import android.os.Bundle;
        import android.os.Handler;
        import android.os.Message;
        import android.view.View;
        import android.widget.ImageView;
        import android.widget.TextView;

public class Splash extends Activity {

    private static final int STOPSPLASH = 0;
    //time in milliseconds
    private static final long SPLASHTIME = 3000;

    private ImageView splash;
    private TextView textSplash;

    //handler for splash screen
    private Handler splashHandler = new Handler() {
        /* (non-Javadoc)
        * @see android.os.Handler#handleMessage(android.os.Message)
        */
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case STOPSPLASH:
                    //remove SplashScreen from view, set to main window
                    splash.setVisibility(View.GONE);
                    textSplash.setVisibility(View.GONE);

                    Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                    startActivity(intent);
                    break;
            }
            super.handleMessage(msg);
        }
    };

    public void onCreate(Bundle icicle) {
        super.onCreate(icicle);
        setContentView(R.layout.splash);
        splash = (ImageView) findViewById(R.id.splashscreen);
        textSplash = (TextView) findViewById(R.id.splashText);
        Message msg = new Message();
        msg.what = STOPSPLASH;
        splashHandler.sendMessageDelayed(msg, SPLASHTIME);
    }
}