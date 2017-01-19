//
//  AVMediaManager.swift
//  SnackKit
//
//  Created by kay weng on 19/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import UIKit
import CoreMedia

protocol IAVMediaManager {
    
    func openCamera(controller:UIViewController,editing:Bool?, completion:((_ media:NSData?)->Void)?)
    
    func openVideoCapture(controller:UIViewController,editing:Bool?, completion:((_ media:NSData?)->Void)?)
    
    func openPhotoLibrary(controller:UIViewController, completion:((_ media:NSData?)->Void)?)
    
    func openSavePhotoAlbum(controller:UIViewController,completion:((_ media:NSData?)->Void)?)

}

//*Note, AVMediaManager is singleton instance instead of a static class;
public class AVMediaManager : NSObject, IAVMediaManager, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    public var mediaPicker:UIImagePickerController!
    
    var accessorCallBack:((_ media:NSData?)->Void)?
    
    class var shared: AVMediaManager {
        
        struct Static {
            static var instance: AVMediaManager? = nil
        }
        
        if Static.instance == nil{
            Static.instance = AVMediaManager()
        }
        
        return Static.instance!
    }
    
    override init(){
        super.init()
        
        self.mediaPicker = UIImagePickerController()
        self.mediaPicker.delegate = self
    }
    
    public func openCamera(controller:UIViewController,editing:Bool?, completion:((_ media:NSData?)->Void)?){
        
        self.mediaPicker.sourceType = .camera
        self.mediaPicker.allowsEditing = editing ?? false
        self.mediaPicker.cameraCaptureMode = .photo
        self.mediaPicker.cameraDevice = .rear
        self.mediaPicker.showsCameraControls = true
        
        //the callback is fired when didCancel or pick a media file
        self.accessorCallBack = completion
        
        controller.present(self.mediaPicker, animated: true, completion: nil)
    }
    
    public func openVideoCapture(controller:UIViewController,editing:Bool?,completion:((_ media:NSData?)->Void)?){

        if verifyMediaAccessPermission(sourceType: .camera){
            
            self.mediaPicker.sourceType = .camera
            self.mediaPicker.allowsEditing = editing ?? false
            self.mediaPicker.cameraCaptureMode = .video
            self.mediaPicker.cameraDevice = .rear
            self.mediaPicker.showsCameraControls = true
            
            self.accessorCallBack = completion
           
            controller.present(self.mediaPicker, animated: true, completion: nil)
        }
    }
    
    public func openPhotoLibrary(controller:UIViewController, completion:((_ media:NSData?)->Void)?){
        
        if verifyMediaAccessPermission(sourceType: .photoLibrary){
            
            self.mediaPicker.sourceType = .photoLibrary
            self.accessorCallBack = completion
            
            controller.present(self.mediaPicker, animated: true, completion: nil)
        }
    }
    
    public func openSavePhotoAlbum(controller:UIViewController,completion:((_ media:NSData?)->Void)?){
    
    
        if verifyMediaAccessPermission(sourceType: .savedPhotosAlbum){
            
            self.mediaPicker.sourceType = .savedPhotosAlbum
            self.accessorCallBack = completion
           
            controller.present(self.mediaPicker, animated: true, completion: nil)
        }
    }
    
    private func verifyMediaAccessPermission(sourceType:UIImagePickerControllerSourceType) -> Bool{
        
        
        return true
    }
    
    // MARK: - UIImagePicker
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mode = self.mediaPicker.cameraCaptureMode
        var retData:NSData?
        
        if mode == .photo{
            
            let img = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            retData = UIImagePNGRepresentation(img) as NSData?
            
        }
        
        
        if let _ = self.accessorCallBack{
            self.mediaPicker.dismiss(animated: true, completion: {
                self.accessorCallBack!(retData)
            })
        }
    }
}
