import Flutter
import UIKit
import Photos

public class SwiftNtsPickerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "nts_picker", binaryMessenger: registrar.messenger())
        let instance = SwiftNtsPickerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getPlatformVersion"{
            result("iOS " + UIDevice.current.systemVersion)
        } else if call.method == "getListFile" {

            if let args = call.arguments as? Dictionary<String, Any>,
                let type = args["type"] as? String {
                getMediaFiles(type: type, result: result)
              } else {
                print("Bad type arg")
              }
        }
    }
    
    private func getMediaFiles(type: String, result: @escaping FlutterResult){
        let nts = NTSListFile()
        
        if type == "image" {
            nts.getPhotos(type: .image){(lst: [String]) in
                result(lst)
            }
        }else if type == "video" {
            nts.getPhotos(type: .video){(lst: [String]) in
                result(lst)
            }
        }else if type == "all" {
            var list = [String]()
            var counter = 0
            nts.getPhotos(type: .image){(lst: [String]) in
                list.append(contentsOf:  lst)
                counter+=1
                if counter == 2{
                    result(list)
                }
            }
            nts.getPhotos(type: .video){(lst: [String]) in
                list.append(contentsOf:  lst)
                counter+=1
                if counter == 2{
                    result(list)
                }
            }
        }else{
            print("Type " + type + " is not support")
        }
    }
    
    
}
