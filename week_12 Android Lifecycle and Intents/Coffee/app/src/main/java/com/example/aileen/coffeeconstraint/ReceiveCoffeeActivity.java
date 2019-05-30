package com.example.aileen.coffeeconstraint;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.util.Log;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

public class ReceiveCoffeeActivity extends Activity {

    private String coffeeShop;
    private String coffeeShopURL;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_receive_coffee);

        //get intent
        Intent intent = getIntent();
        coffeeShop = intent.getStringExtra("coffeeShopName");
        coffeeShopURL = intent.getStringExtra("coffeeShopURL");
        Log.i("shop received", coffeeShop);
        Log.i("url received", coffeeShopURL);

        //update text view
        TextView messageView = findViewById(R.id.coffeeShopTextView);
        messageView.setText("You should check out " + coffeeShop);

        //get image button
        ImageButton imageButton = findViewById(R.id.imageButton);
        //create listener
        View.OnClickListener onclick = new View.OnClickListener(){
            public void onClick(View view){
                loadWebSite(view);
            }
        };

        //add listener to the button
        imageButton.setOnClickListener(onclick);
    }

    private void loadWebSite(View view){
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse(coffeeShopURL));
        startActivity(intent);
    }
}
