package com.example.qrcode

import android.content.Intent
import android.provider.ContactsContract
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "contact"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            val intent = Intent(Intent.ACTION_INSERT)
            intent.setType(ContactsContract.Contacts.CONTENT_TYPE)

            intent.putExtra(ContactsContract.Intents.Insert.NAME, "abc")
            intent.putExtra(ContactsContract.Intents.Insert.PHONE, "2312345646")
            intent.putExtra(ContactsContract.Intents.Insert.EMAIL, "asdasd@asdasd")
            context.startActivity(intent)
            result.success(call.arguments)
        }
    }

}
