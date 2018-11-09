package com.example.aileen.halloween;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

public class MainActivity extends Activity {
    private String message;
    private ImageView ghost;
    private TextView booText;

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        //save current state
        outState.putString("msg", message);
        outState.putInt("imageid", R.drawable.ghost);

        //always call the superclass so it can save the view hierarchy state
        super.onSaveInstanceState(outState);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        booText = findViewById(R.id.message);
        ghost = findViewById(R.id.imageView);

        //check for recovering the instance state
        if (savedInstanceState !=null){
            message = savedInstanceState.getString("msg");
            int image_id = savedInstanceState.getInt("imageid");

            booText.setText(message);
            ghost.setImageResource(image_id);
        }
    }

    public void sayBoo(View view) {
        booText = findViewById(R.id.message);
        EditText name = findViewById(R.id.editText);
        String nameValue = name.getText().toString();
        message = "Happy Halloween " + nameValue + "!";
        booText.setText(message);
        ghost = findViewById(R.id.imageView);
        ghost.setImageResource(R.drawable.ghost);
    }
}
