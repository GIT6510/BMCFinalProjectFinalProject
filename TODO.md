# Performance Optimization TODO

## 1. Enable code shrinking and resource shrinking in release builds
- Edit `android/app/build.gradle.kts` to add `minifyEnabled = true` and `shrinkResources = true` in release buildType. ✅ DONE

## 2. Defer non-essential initializations
- Modify `lib/main.dart` to defer CartProvider auth listener setup after runApp if possible, to avoid blocking UI thread. ✅ DONE

## 3. Optimize HomeScreen
- Make user role fetch lazy in `lib/screens/home_screen.dart`. ✅ DONE
- Optimize StreamBuilders to avoid unnecessary rebuilds. (No changes needed as StreamBuilders are already efficient)

## 4. Add performance optimizations
- Enable multidex in `android/app/build.gradle.kts` if APK size exceeds 64K methods. ✅ DONE
- Ensure release mode builds are optimized. ✅ DONE

## 5. Test the APK
- Build APK in release mode.
- Test opening speed on Android device.
- Monitor for regressions.
