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
        self.imageManager.allowsCachingHighQualityImages = true
       
        PHPhotoLibrary.shared().register(self)
    }
    
    public func photoLibraryDidChange(_ changeInstance: PHChange) {
        self.resetCachedAssets()
    }
    
    fileprivate func enumeratePHAssets(result:PHFetchResult<AnyObject>)->[PHAsset]?{
        
        var assets:[PHAsset]?
        
        if result.count > 0 {
            assets = []
            
            result.enumerateObjects({ (object, count, stop) in
                assets!.append(object as! PHAsset)
            })
        }
        
        return assets
    }
    
    public func startCachingPHAssets(_ assets:[PHAsset], targetSize size:CGSize, contentMode mode:PHImageContentMode, options:PHImageRequestOptions?){
        
        self.imageManager.startCachingImages(for: assets, targetSize: size, contentMode: mode, options: options)
    }
    
    public func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }

    //MARK: - FetchAssets
    public func fetchAssets(options:PHFetchOptions?)->[PHAsset]?{
        
        let auth = requestAuthorization()
        
        guard auth.granted else {
            return nil
        }
        
        let fetchResult = PHAsset.fetchAssets(with: options)
        let assets = enumeratePHAssets(result: fetchResult as! PHFetchResult<AnyObject>)
        
        return assets
    }
    
    public func fetchAssets(localIdentifiers:[String], options:PHFetchOptions?)->[PHAsset]?{
        
        let auth = requestAuthorization()
        
        guard auth.granted else {
            return nil
        }
        
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: localIdentifiers, options: options)
        let assets = enumeratePHAssets(result: fetchResult as! PHFetchResult<AnyObject>)
        
        return assets
    }
    
    public func fetchAssets(collection:PHAssetCollection, options:PHFetchOptions?)->[PHAsset]?{
        
        let auth = requestAuthorization()
        
        guard auth.granted else {
            return nil
        }
        
        let fetchResult = PHAsset.fetchAssets(in: collection, options: options)
        let assets = enumeratePHAssets(result: fetchResult as! PHFetchResult<AnyObject>)
        
        return assets
    }
    
    public func fetchAssets(mediaType:PHAssetMediaType, options:PHFetchOptions)->[PHAsset]?{
        
        let auth = requestAuthorization()
        
        guard auth.granted else {
            return nil
        }
        
        let fetchResult = PHAsset.fetchAssets(with: mediaType, options: options)
        let assets = enumeratePHAssets(result: fetchResult as! PHFetchResult<AnyObject>)
        
        return assets
    }
    
    //MARK: - FetchAssetCollection
    public func fetchAssetCollection(with type:PHAssetCollectionType, subType:PHAssetCollectionSubtype, options: PHFetchOptions?)->[PHAsset]?{
        
        let auth = requestAuthorization()
        
        guard auth.granted else {
            return nil
        }
        
        let collectionFetchResult = PHAssetCollection.fetchAssetCollections(with: type, subtype: subType, options: nil)
       
        if let collection:PHAssetCollection = collectionFetchResult.firstObject{
            let fetchResult = PHAsset.fetchAssets(in: collection, options: options)
            let assets = enumeratePHAssets(result: fetchResult as! PHFetchResult<AnyObject>)
            
            return assets
        }
       
        return nil
    }
    
    //MARK: - Fetch Photo Asset
    public func fetchAssetImageData(asset:PHAsset, options:PHImageRequestOptions?, completion:@escaping (UIImage?)->Void){
    
        let auth = requestAuthorization()
        
        if auth.granted{
            imageManager.requestImageData(for: asset, options: options) { (data, _, _, _) in
                
                if let img = UIImage(data: data!){
                    completion(img)
                }else{
                    completion(nil)
                }
            }
        }else{
            completion(nil)
        }
    }
    
    public func fetchAssetImage(asset:PHAsset,targetSize size:CGSize, mode:PHImageContentMode, options:PHImageRequestOptions?, completion:@escaping (UIImage?)->Void){
        
        let auth = requestAuthorization()
        
        if auth.granted{
            imageManager.requestImage(for: asset, targetSize: size, contentMode: mode, options: options) { (image, info) in
                completion(image)
            }
        }else{
            completion(nil)
        }
    }

    // MARK: - Fetch AV Asset
    public func fetchAssetVideo(asset:PHAsset, options:PHVideoRequestOptions?, completion:@escaping (AVURLAsset?)->Void){
        
        let auth = requestAuthorization()
        
        guard auth.granted else {
            completion(nil)
            return
        }

        let group = DispatchGroup()
        group.enter()
        
        PHCachingImageManager().requestAVAsset(forVideo: asset, options: options) { (av, audio, info) in
        
            if let assetURL = av{
                completion(assetURL as? AVURLAsset)
            }else{
                completion(nil)
            }
            
            group.leave()
        }
        
        group.wait()
    }
    
    public func getThumbnailFor(asset:PHAsset, completionHandler:@escaping (_ thumbnail:UIImage?)->()){
        
        asset.getURL { (path) in
            do{
                if let url = path{
                    let asset = AVURLAsset(url: url , options: nil)
                    let imgGenerator = AVAssetImageGenerator(asset: asset)
                    
                    imgGenerator.appliesPreferredTrackTransform = true
                    
                    let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                    let thumbnail = UIImage(cgImage: cgImage)
                    
                    completionHandler(thumbnail)
                }else{
                    completionHandler(nil)
                }
            }catch let error {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }

    //MARK: - Authorization
    public func requestAuthorization()->PHPhotoLibraryAuthResult{
        
        var authorizationResult:PHPhotoLibraryAuthResult = (PHAuthorizationStatus.notDetermined, false, "")
        
        let group = DispatchGroup()
        group.enter()
        
        PHPhotoLibrary.requestAuthorization { (status) in
            authorizationResult.status = status
            authorizationResult.granted = false
            
            switch status{
            case .authorized:
                authorizationResult.message = "You have been granted to access photo library"
                authorizationResult.granted = true
            case .denied:
                authorizationResult.message = "Access denied to photo library"
            case .notDetermined:
                authorizationResult.message = "You are not determine access to photo library"
            case .restricted:
                authorizationResult.message = "You are restricted to access photo library"
            }
            
            group.leave()
        }
        
        group.wait()
        
        return authorizationResult
    }
}
