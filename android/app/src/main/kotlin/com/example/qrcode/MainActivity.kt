package com.example.qrcode

import android.content.*
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.wifi.WifiConfiguration
import android.net.wifi.WifiManager
import android.net.wifi.WifiNetworkSpecifier
import android.net.wifi.WifiNetworkSuggestion
import android.os.Build
import android.provider.ContactsContract
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import co.quis.flutter_contacts.properties.Email
import co.quis.flutter_contacts.properties.Organization
import co.quis.flutter_contacts.properties.Website
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val contact = "contact"
    private val wifi = "wifi"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                contact
        ).setMethodCallHandler { call, result ->
            val intent = Intent(Intent.ACTION_INSERT).apply {
                type = ContactsContract.Contacts.CONTENT_TYPE
            }

            val data = ArrayList<ContentValues>()
            val content = call.arguments as Map<*, *>

            //name
            var name = "";
            if (content["displayName"].toString().isNotEmpty()) {
                name = content["displayName"].toString()
            } else {
                val nameMap = content["name"] as Map<*, *>
                if (nameMap["last"].toString().isNotEmpty()) {
                    name += nameMap["last"].toString()
                }
                if (nameMap["middle"].toString().isNotEmpty()) {
                    name += " " + nameMap["middle"].toString()
                }
                if (nameMap["first"].toString().isNotEmpty()) {
                    name += " " + nameMap["first"].toString()
                }
            }
            intent.putExtra(ContactsContract.Intents.Insert.NAME, name)

            //phone
            val phones = content["phones"] as List<*>
            for (element in phones) {
                element as Map<*, *>
                val row = ContentValues()
                row.put(
                        ContactsContract.Data.MIMETYPE,
                        ContactsContract.CommonDataKinds.Phone.CONTENT_ITEM_TYPE
                )
                var type = ContactsContract.CommonDataKinds.Phone.TYPE_MOBILE
                when (element["label"]) {
                    "assistant" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_ASSISTANT
                    "callback" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_CALLBACK
                    "car" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_CAR
                    "faxHome" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_FAX_HOME
                    "faxOther" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_OTHER_FAX
                    "faxWork" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_FAX_WORK
                    "home" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_HOME
                    "isdn" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_ISDN
                    "main" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_MAIN
                    "mms" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_MMS
                    "mobile" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_MOBILE
                    "pager" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_PAGER
                    "radio" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_RADIO
                    "school" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_WORK
                    "telex" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_TELEX
                    "ttyTtd" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_TTY_TDD
                    "work" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_WORK
                    "workMobile" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_WORK_MOBILE
                    "workPager" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_WORK_PAGER
                    "other" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_OTHER
                    "custom" -> type = ContactsContract.CommonDataKinds.Phone.TYPE_CUSTOM
                }
                row.put(ContactsContract.CommonDataKinds.Phone.TYPE, type)
                row.put(ContactsContract.CommonDataKinds.Phone.NUMBER, element["number"].toString())
                data.add(row)
            }

            //email
            val emails = content["emails"] as List<*>
            for (element in emails) {
                element as Map<*, *>
                val row = ContentValues()
                row.put(
                        ContactsContract.Data.MIMETYPE,
                        ContactsContract.CommonDataKinds.Email.CONTENT_ITEM_TYPE
                )
                var type = ContactsContract.CommonDataKinds.Email.TYPE_HOME
                when (element["label"]) {
                    "home" -> type = ContactsContract.CommonDataKinds.Email.TYPE_HOME
                    "iCloud" -> type = ContactsContract.CommonDataKinds.Email.TYPE_OTHER
                    "mobile" -> type = ContactsContract.CommonDataKinds.Email.TYPE_MOBILE
                    "school" -> type = ContactsContract.CommonDataKinds.Email.TYPE_OTHER
                    "work" -> type = ContactsContract.CommonDataKinds.Email.TYPE_WORK
                    "other" -> type = ContactsContract.CommonDataKinds.Email.TYPE_OTHER
                    "custom" -> type = ContactsContract.CommonDataKinds.Email.TYPE_CUSTOM
                }
                row.put(ContactsContract.CommonDataKinds.Email.TYPE, type)
                row.put(
                        ContactsContract.CommonDataKinds.Email.ADDRESS,
                        element["address"].toString()
                )
                data.add(row)
            }

            //address
            val addresses = content["addresses"] as List<*>
            for (element in addresses) {
                element as Map<*, *>
                val row = ContentValues()
                row.put(
                        ContactsContract.Data.MIMETYPE,
                        ContactsContract.CommonDataKinds.StructuredPostal.CONTENT_ITEM_TYPE
                )
                var type = ContactsContract.CommonDataKinds.StructuredPostal.TYPE_HOME
                when (element["label"]) {
                    "home" -> type = ContactsContract.CommonDataKinds.StructuredPostal.TYPE_HOME
                    "school" -> type = ContactsContract.CommonDataKinds.StructuredPostal.TYPE_OTHER
                    "work" -> type = ContactsContract.CommonDataKinds.StructuredPostal.TYPE_WORK
                    "other" -> type = ContactsContract.CommonDataKinds.StructuredPostal.TYPE_OTHER
                    "custom" -> type = ContactsContract.CommonDataKinds.StructuredPostal.TYPE_CUSTOM

                }

                if (element["street"].toString().isEmpty() && element["city"].toString()
                                .isEmpty() && element["state"].toString()
                                .isEmpty() && element["country"].toString().isEmpty()
                ) {
                    intent.putExtra(
                            ContactsContract.Intents.Insert.POSTAL,
                            element["address"].toString()
                    )
                    intent.putExtra(ContactsContract.Intents.Insert.POSTAL_TYPE, type)
                } else {
                    row.put(ContactsContract.CommonDataKinds.StructuredPostal.TYPE, type)
                    row.put(
                            ContactsContract.CommonDataKinds.StructuredPostal.STREET,
                            element["street"].toString()
                    )
                    row.put(
                            ContactsContract.CommonDataKinds.StructuredPostal.POBOX,
                            element["pobox"].toString()
                    )
                    row.put(
                            ContactsContract.CommonDataKinds.StructuredPostal.NEIGHBORHOOD,
                            element["neighborhood"].toString()
                    )
                    row.put(
                            ContactsContract.CommonDataKinds.StructuredPostal.CITY,
                            element["city"].toString()
                    )
                    row.put(
                            ContactsContract.CommonDataKinds.StructuredPostal.REGION,
                            element["state"].toString()
                    )
                    row.put(
                            ContactsContract.CommonDataKinds.StructuredPostal.POSTCODE,
                            element["postalCode"].toString()
                    )
                    row.put(
                            ContactsContract.CommonDataKinds.StructuredPostal.COUNTRY,
                            element["country"].toString()
                    )
                    data.add(row)
                }
            }

            //organizations
            val organizations = content["organizations"] as List<*>
            for (element in organizations) {
                element as Map<*, *>
                val row = ContentValues()
                row.put(
                        ContactsContract.Data.MIMETYPE,
                        ContactsContract.CommonDataKinds.Organization.CONTENT_ITEM_TYPE
                )

                row.put(
                        ContactsContract.CommonDataKinds.Organization.COMPANY,
                        element["company"].toString()
                )
                row.put(
                        ContactsContract.CommonDataKinds.Organization.TITLE,
                        element["title"].toString()
                )
                row.put(
                        ContactsContract.CommonDataKinds.Organization.DEPARTMENT,
                        element["department"].toString()
                )
                row.put(
                        ContactsContract.CommonDataKinds.Organization.JOB_DESCRIPTION,
                        element["jobDescription"].toString()
                )
                row.put(
                        ContactsContract.CommonDataKinds.Organization.SYMBOL,
                        element["symbol"].toString()
                )
                row.put(
                        ContactsContract.CommonDataKinds.Organization.PHONETIC_NAME,
                        element["phoneticName"].toString()
                )
                row.put(
                        ContactsContract.CommonDataKinds.Organization.OFFICE_LOCATION,
                        element["officeLocation"].toString()
                )
                data.add(row)
            }

            //websites
            val websites = content["websites"] as List<*>
            for (element in websites) {
                element as Map<*, *>
                val row = ContentValues()
                row.put(
                        ContactsContract.Data.MIMETYPE,
                        ContactsContract.CommonDataKinds.Website.CONTENT_ITEM_TYPE
                )
                var type = ContactsContract.CommonDataKinds.Website.TYPE_HOME
                when (element["label"]) {
                    "home" -> type = ContactsContract.CommonDataKinds.Website.TYPE_HOME
                    "blog" -> type = ContactsContract.CommonDataKinds.Website.TYPE_BLOG
                    "ftp" -> type = ContactsContract.CommonDataKinds.Website.TYPE_FTP
                    "homepage" -> type = ContactsContract.CommonDataKinds.Website.TYPE_HOMEPAGE
                    "profile" -> type = ContactsContract.CommonDataKinds.Website.TYPE_PROFILE
                    "school" -> type = ContactsContract.CommonDataKinds.Website.TYPE_OTHER
                    "work" -> type = ContactsContract.CommonDataKinds.Website.TYPE_WORK
                    "other" -> type = ContactsContract.CommonDataKinds.Website.TYPE_OTHER
                    "custom" -> type = ContactsContract.CommonDataKinds.Website.TYPE_CUSTOM

                }
                row.put(ContactsContract.CommonDataKinds.Website.TYPE, type)
                row.put(
                        ContactsContract.CommonDataKinds.Website.URL,
                        element["url"].toString()
                )
                data.add(row)
            }

            //events
            val events = content["events"] as List<*>
            for (element in events) {
                element as Map<*, *>
                val row = ContentValues()
                row.put(
                        ContactsContract.Data.MIMETYPE,
                        ContactsContract.CommonDataKinds.Event.CONTENT_ITEM_TYPE
                )
                var type = ContactsContract.CommonDataKinds.Event.TYPE_CUSTOM
                when (element["label"]) {
                    "anniversary" -> type = ContactsContract.CommonDataKinds.Event.TYPE_ANNIVERSARY
                    "birthday" -> type = ContactsContract.CommonDataKinds.Event.TYPE_BIRTHDAY
                    "other" -> type = ContactsContract.CommonDataKinds.Event.TYPE_OTHER
                    "custom" -> type = ContactsContract.CommonDataKinds.Event.TYPE_CUSTOM
                }
                row.put(ContactsContract.CommonDataKinds.Event.TYPE, type)
                row.put(
                        ContactsContract.CommonDataKinds.Event.START_DATE,
                        element["year"].toString() + "/" + element["month"].toString() + "/" + element["day"].toString()
                )
                data.add(row)
            }

            //notes
            val notes = content["notes"] as List<*>
            for (element in notes) {
                element as Map<*, *>
                val row = ContentValues()
                row.put(
                        ContactsContract.Data.MIMETYPE,
                        ContactsContract.CommonDataKinds.Note.CONTENT_ITEM_TYPE
                )
                row.put(ContactsContract.CommonDataKinds.Note.NOTE, element["note"].toString())
                data.add(row)
            }

            intent.putParcelableArrayListExtra(ContactsContract.Intents.Insert.DATA, data)

            context.startActivity(intent)
            result.success(call.arguments)
        }

        MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                wifi
        ).setMethodCallHandler { call, result ->
            val wifiConfig = call.arguments as Map<*, *>
            val networkSSID = wifiConfig["ssid"].toString()
            val networkPass = wifiConfig["password"].toString()
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                val wifiNetworkSpecifier: WifiNetworkSpecifier?

                if (networkPass.isEmpty()) {
                    wifiNetworkSpecifier =
                            WifiNetworkSpecifier.Builder().setSsid(networkSSID).build()
                } else {
                    wifiNetworkSpecifier = WifiNetworkSpecifier.Builder().setSsid(networkSSID)
                            .setWpa2Passphrase(networkPass).build()
                }

                val networkRequest = NetworkRequest.Builder()
                        .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
                        .removeCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
                        .setNetworkSpecifier(wifiNetworkSpecifier)
                        .build()

                val connectivityManager =
                        context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager?

                val networkCallback = object : ConnectivityManager.NetworkCallback() {
                    override fun onUnavailable() {
                        super.onUnavailable()
                    }

                    override fun onLosing(network: Network, maxMsToLive: Int) {
                        super.onLosing(network, maxMsToLive)

                    }

                    override fun onAvailable(network: Network) {
                        super.onAvailable(network)
                        connectivityManager?.bindProcessToNetwork(network)
                    }

                    override fun onLost(network: Network) {
                        super.onLost(network)

                    }
                }
                connectivityManager?.requestNetwork(networkRequest, networkCallback)


            } else {
                val wifiManager = context.getSystemService(WIFI_SERVICE) as WifiManager?

//                if (havePermission) {
//                    var found = false
//                    for (config in wifiManager?.configuredNetworks!!) {
//                        if (config.SSID == String.format("\"%s\"", wifi.SSID)) {
//                            wifiManager.enableNetwork(config.networkId, true)
//                            found = true
//                            break
//                        }
//                    }
//
//                    if (!found) {
//                        val wifiConfiguration = WifiConfiguration()
//                        wifiConfiguration.SSID = String.format("\"%s\"", networkSSID)
//                        wifiConfiguration.preSharedKey = String.format("\"%s\"", networkPass)
//                        val wifiID = wifiManager?.addNetwork(wifiConfiguration)
//                        if (wifiID != null) {
//                            wifiManager?.enableNetwork(wifiID, true)
//                        }
//                    }
//                }
            }
            result.success("success")
        }
    }

    private var lastSuggestedNetwork: WifiNetworkSuggestion? = null
    var wifiManager: WifiManager? = null

    @RequiresApi(Build.VERSION_CODES.Q)
    private fun connectUsingNetworkSuggestion(ssid: String, password: String) {
        val wifiNetworkSuggestion = WifiNetworkSuggestion.Builder()
                .setSsid(ssid)
                .setWpa2Passphrase(password)
                .build()
        val intentFilter =
                IntentFilter(WifiManager.ACTION_WIFI_NETWORK_SUGGESTION_POST_CONNECTION);

        val broadcastReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                if (!intent.action.equals(WifiManager.ACTION_WIFI_NETWORK_SUGGESTION_POST_CONNECTION)) {
                    return
                }
                showToast("Connection Suggestion Succeeded")
            }
        }


        registerReceiver(broadcastReceiver, intentFilter)

        lastSuggestedNetwork?.let {
            val status = wifiManager!!.removeNetworkSuggestions(listOf(it))
        }
        val suggestionsList = listOf(wifiNetworkSuggestion)

        var status = wifiManager!!.addNetworkSuggestions(suggestionsList)
        if (status == WifiManager.STATUS_NETWORK_SUGGESTIONS_ERROR_ADD_DUPLICATE) {
            showToast("Suggestion Update Needed")
            status = wifiManager!!.removeNetworkSuggestions(suggestionsList)
            status = wifiManager!!.addNetworkSuggestions(suggestionsList)
        }
        if (status == WifiManager.STATUS_NETWORK_SUGGESTIONS_SUCCESS) {
            lastSuggestedNetwork = wifiNetworkSuggestion
            showToast("Suggestion Added")
        }
    }

    private fun showToast(s: String) {
        Toast.makeText(applicationContext, s, Toast.LENGTH_LONG).show()
    }
}
