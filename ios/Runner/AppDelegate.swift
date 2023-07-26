import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        if let controller = window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(name: "com.kbtg.academy", binaryMessenger: controller.binaryMessenger)
            channel.setMethodCallHandler({
                [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
                switch call.method {
                case "getBatteryLevel":
                    self?.receiveBatteryLevel(result: result)
                case "getInt":
                    let randomInt = Int.random(in: 1..<5)
                    result(randomInt)
                default:
                    result(FlutterMethodNotImplemented)
                }
            })
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(FlutterError(code: "UNAVAILABLE",
                                message: "Battery level not available.",
                                details: nil))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
}
