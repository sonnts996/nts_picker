//
//  NTSListFiles.swift
//  nts_picker
//
//  Created by admin on 31/12/2021.
//

import Foundation
import Photos

class NTSListFile {
    
    typealias CompletionHandler = (_: [String]) -> Void;
    typealias AdditionHandler = (_:String?) -> Void;
    
    public func getPhotos(type: PHAssetMediaType, completionHandler: @escaping CompletionHandler) -> Void {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        var list = [String]()
        let results: PHFetchResult = PHAsset.fetchAssets(with: type, options: fetchOptions)
        if results.count > 0 {
            for i in 0..<results.count {
                let asset = results.object(at: i)
                if type == PHAssetMediaType.image {
                    getImages(asset: asset) {(path: String?) in
                        if path != nil {
                            list.append(self.toJsonString(data: path!, type: "image"))
                        }
                        if results.count == i + 1 {
                            completionHandler(list)
                        }
                    }
                    
                } else if type == PHAssetMediaType.video {
                    getVideos(asset: asset) {(path: String?) in
                        if path != nil {
                            list.append(self.toJsonString(data: path!, type: "video"))
                        }
                        if results.count == i + 1 {
                            completionHandler(list)
                        }
                    }
                }
                
            }
        } else {
            print("no photos to display")
        }
    }
    
    func toJsonString(data: String,  type: String) -> String{
        return  "{\"path\":\"" + data + "\", \"mediaType\": \"" + type + "\"}"
    }
    
    func getImages(asset: PHAsset, additionHandler: @escaping AdditionHandler){
        asset.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) {
            (editingInput, info) in
            if let input = editingInput, let photoUrl = input.fullSizeImageURL {
                additionHandler(photoUrl.path);
            }else {
                additionHandler(nil)
            }
        }
    }
    
    func getVideos(asset: PHAsset, additionHandler: @escaping AdditionHandler) {
        let options: PHVideoRequestOptions = PHVideoRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .fastFormat
        options.version = .current
        PHImageManager().requestAVAsset(forVideo: asset, options: options, resultHandler: { (rs_asset, audioMix, info) in
            if let urlAsset = rs_asset as? AVURLAsset {
                let localVideoUrl = urlAsset.url
                additionHandler(localVideoUrl.path)
            } else {
                additionHandler(nil)
            }
        })
    }
}
