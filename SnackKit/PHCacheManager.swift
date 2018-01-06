//
//  PHCacheManager.swift
//  SnackKit
//
//  Created by kay weng on 06/01/2018.
//  Copyright © 2018 snackcode.org. All rights reserved.
//

import Foundation
import Photos
import PhotosUI

public typealias PHPhotoLibraryAuthResult = (status:PHAuthorizationStatus, granted:Bool, message:String)

public class PHCacheManager: NSObject, PHPhotoLibraryChangeObserver {
    
    private var imageManager: PHCachingImageManager!
    
    public class var shared: PHCacheManager {
        
        struct Static {
            static var instance: PHCacheManager? = nil
        }
        
        if Static.instance == nil{
            Static.instance = PHCacheManager()
        }
        
        return Static.instance!
    }
    
    override init() {
        super.init()
        
        self.imageManager = PHCachingImageManager()
        
        PHPhotoLibrary.shared().register(self)
        
        self.ResetCachedAssets()
    }
    
    public func photoLibraryDidChange(_ changeInstance: PHChange) {
        self.ResetCachedAssets()
    }
    
    public func FetchPHAssets(mediaType:PHAssetMediaType, options:PHFetchOptions)->[PHAsset]?{
        
        var phAssets:[PHAsset]?
        let auth = RequestAuthorization()
        
        guard auth.granted else {
            return phAssets
        }
        
        self.ResetCachedAssets()
        
        let assets = PHAsset.fetchAssets(with: mediaType, options: options)

        if assets.count > 0 {
            phAssets = []
            
            assets.enumerateObjects({ (object, count, stop) in
                phAssets!.append(object)
            })
        }

        return phAssets
    }
    
    public func FetchAssetImage(asset:PHAsset,targetSize size:CGSize, mode:PHImageContentMode, options:PHImageRequestOptions? )->UIImage?{
        
        var assetImage:UIImage?
        let auth = RequestAuthorization()
        
        guard auth.granted else {
            return nil
        }
        
        imageManager.requestImage(for: asset, targetSize: size, contentMode: mode, options: options) { (image, info) in
            assetImage = image
        }
        
        return assetImage
    }
    
    public func ResetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    public func RequestAuthorization()->PHPhotoLibraryAuthResult{
        
        var authorizationResult:PHPhotoLibraryAuthResult = (PHAuthorizationStatus.notDetermined, false, "")
        
        let group = DispatchGroup()
        group.enter()
        
        PHPhotoLibrary.requestAuthorization { (status) in
            authorizationResult.status = status
            
            switch status{
            case .authorized:
                authorizationResult.message = "You have been granted to access photo library"
                authorizationResult.granted = true
            case .denied:
                authorizationResult.message = "Access denied to photo library"
                authorizationResult.granted = false
            case .notDetermined:
                authorizationResult.message = "You are not determine access to photo library"
                authorizationResult.granted = false
            case .restricted:
                authorizationResult.message = "You are restricted to access photo library"
                authorizationResult.granted = false
            }
            
            group.leave()
        }
        
        group.wait()
        
        return authorizationResult
    }
    
}
