//
//  MFMailManager.swift
//  SnackKit
//
//  Created by kay weng on 19/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation
import MessageUI

protocol IMFMailManager {
    
    func composeEmail(content:mailContent, in controller:UIViewController, completion:((_ status:String)->Void)?)
    func discardDraft()->Bool
}

public typealias mailContent = (recipients:[String], subject:String?, message:String?, attachments:[mailAttachment]?)
public typealias mailAttachment = (name:String, type:String, fileData:Data)

public class MFMailManager:NSObject, MFMailComposeViewControllerDelegate{
    
    var mailComposerVC:MFMailComposeViewController!
    var delegateController:UIViewController!
    var callBack:((_ status:String)->Void?)!
    
    class var shared: MFMailManager {
        
        struct Static {
            static var instance: MFMailManager? = nil
        }
        
        if Static.instance == nil{
            Static.instance = MFMailManager()
        }
        
        return Static.instance!
    }
    
    override init() {
        super.init()
        
        self.delegateController = nil
        self.callBack = nil
        self.mailComposerVC = MFMailComposeViewController()
    }
    
    public func composeEmail(content:mailContent, forController controller:UIViewController, completion:((_ status:String)->Void)?){
     
        self.delegateController = controller
        
        mailComposerVC.setToRecipients(content.recipients)
        mailComposerVC.setSubject(content.subject ?? "")
        mailComposerVC.setMessageBody(content.message ?? "", isHTML: false)
        
        if let attachmentFiles = content.attachments {
            
            for att in attachmentFiles{
                mailComposerVC.addAttachmentData(att.fileData as Data, mimeType: att.type, fileName: att.name)
            }
        }
        
        controller.present(self.mailComposerVC, animated: true, completion: {
            
            if let comp = completion{
                self.callBack = comp
                comp("Sending ...")
            }
        })
    }
    
    public func discardDraft()->Bool{
        return true
    }
    
    // MARK : - MFMailCompose Delegate
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch (result)
        {
            
        case .cancelled:
            self.callBack("Cancelled")
        case .failed:
            self.callBack("Failed")
        case .saved:
            self.callBack("Saved")
        case .sent:
            self.callBack("Sent")
        
        }
    }
}
