package com.example.flutter_96739

import com.nt4f04und.android_content_provider.AndroidContentProvider

class MyAndroidContentProvider : AndroidContentProvider() {
   override val authority: String = "com.example.myapp.MyAndroidContentProvider"
   override val entrypointName = "exampleContentProviderEntrypoint"
}
