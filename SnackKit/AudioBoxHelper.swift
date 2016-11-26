//
//  AudioBoxManager.swift
//  SnackKit
//
//  Created by kay weng on 19/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import AudioToolbox

public class AudioBox{
    
    public static func playSound(name soundName:String, ofType:String){
        
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: ofType) {
            
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
    }
}
