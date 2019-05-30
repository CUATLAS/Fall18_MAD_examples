package com.example.aileen.halloween;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void sayBoo(View view) {
        TextView booText = findViewById(R.id.message);
        EditText name = findViewById(R.id.editText);
        String nameValue = name.getText().toString();
        booText.setText("Happy Halloween " + nameValue + "!");
        ImageView ghost = findViewById(R.id.imageView);
        ghost.setImageResource(R.drawable.ghost);
    }
}
