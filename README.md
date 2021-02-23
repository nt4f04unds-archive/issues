issue https://github.com/flutter/flutter/issues/76640

app crashes "Semantics update contained scrollChildren but did not have childrenInHitTestOrder" with very long ListView

in `logs` folder there's

* `healthy` log that was produced on Xiaomi Redmi Redmi Note 5 Android 9
* `crash` log that was produced on iPhone SE (2nd generation) iOS 13.7

to clone use

```
git clone -b flutter_76640 --single-branch git@github.com:nt4f04unds-archive/issues.git
```