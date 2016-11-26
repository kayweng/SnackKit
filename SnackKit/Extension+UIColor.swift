//
//  Extension+UIColor.swift
//  PocketMerchant
//
//  Created by kay weng on 11/05/2016.
//  Copyright © 2016 pocket-app. All rights reserved.
//

import UIKit

// MARK:- UIColor
extension UIColor {
    
    public class func parseHue(color:UIColor,saturation:CGFloat?, brightness:CGFloat?, alpha:CGFloat?)->UIColor{
        
        var h:CGFloat = 0.0
        var b:CGFloat = 0.0
        var s:CGFloat = 0.0
        var a:CGFloat = 0.0
        
        if !color.getHue(&h, saturation: &s, brightness: &b, alpha: &a){
            return color
        }
        
        return UIColor(hue: h, saturation: saturation!, brightness: brightness!, alpha: alpha!)
    }
    
    public class func random()->UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    public class func facebook()->UIColor {
        return UIColor(red: 58/255, green: 89/255, blue: 152/255, alpha: 1.0)
    }
    
    //1st row
    public class func licorice()->UIColor{
         return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func lead()->UIColor{
        return UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
    }
    
    public class func tungsten()->UIColor{
        return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    }
    
    public class func iron()->UIColor{
        return UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
    }
    
    public class func steel()->UIColor{
        return UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
    }
    
    public class func tin()->UIColor{
        return UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1.0)
    }
    
    public class func nickel()->UIColor{
        return UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
    }
    
    public class func aluminum()->UIColor{
        return UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
    }
    
    public class func magnesium()->UIColor{
        return UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0)
    }
    
    public class func silver()->UIColor{
        return UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    }
    
    public class func mercury()->UIColor{
        return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    }
    
    public class func snow()->UIColor{
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }
    
    //2nd row
    public class func cayenne()->UIColor{
        return UIColor(red: 128/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func mocha()->UIColor{
        return UIColor(red: 128/255, green: 64/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func asparagus()->UIColor{
        return UIColor(red: 128/255, green: 128/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func fern()->UIColor{
        return UIColor(red: 64/255, green: 128/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func clover()->UIColor{
        return UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func moss()->UIColor{
        return UIColor(red: 0/255, green: 128/255, blue: 64/255, alpha: 1.0)
    }
    
    public class func teal()->UIColor{
        return UIColor(red: 0/255, green: 128/255, blue: 128/255, alpha: 1.0)
    }
    
    public class func ocean()->UIColor{
        return UIColor(red: 0/255, green: 64/255, blue: 128/255, alpha: 1.0)
    }
    
    public class func midnight()->UIColor{
        return UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1.0)
    }
    
    public class func eggplant()->UIColor{
        return UIColor(red: 64/255, green: 0/255, blue: 128/255, alpha: 1.0)
    }
    
    public class func plum()->UIColor{
        return UIColor(red: 128/255, green: 0/255, blue: 128/255, alpha: 1.0)
    }
    
    public class func maroon()->UIColor{
        return UIColor(red: 128/255, green: 0/255, blue: 64/255, alpha: 1.0)
    }
    
    //3rd row
    public class func maraschino()->UIColor{
        return UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func tangerine()->UIColor{
        return UIColor(red: 255/255, green: 128/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func lemon()->UIColor{
        return UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func lime()->UIColor{
        return UIColor(red: 128/255, green: 255/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func spring()->UIColor{
        return UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
    }
    
    public class func seaFoam()->UIColor{
        return UIColor(red: 0/255, green: 255/255, blue: 128/255, alpha: 1.0)
    }
    
    public class func turquoise()->UIColor{
        return UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func aqua()->UIColor{
        return UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func blueberry()->UIColor{
        return UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func grape()->UIColor{
        return UIColor(red: 128/255, green: 0/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func magenta()->UIColor{
        return UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func strawberry()->UIColor{
        return UIColor(red: 255/255, green: 0/255, blue: 128/255, alpha: 1.0)
    }
    
    //4th row
    public class func salmon()->UIColor{
        return UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1.0)
    }
    
    public class func cantaloupe()->UIColor{
        return UIColor(red: 255/255, green: 204/255, blue: 102/255, alpha: 1.0)
    }
    
    public class func banana()->UIColor{
        return UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1.0)
    }
    
    public class func honeydew()->UIColor{
        return UIColor(red: 204/255, green: 255/255, blue: 102/255, alpha: 1.0)
    }
    
    public class func flora()->UIColor{
        return UIColor(red: 102/255, green: 255/255, blue: 102/255, alpha: 1.0)
    }
    
    public class func spindrift()->UIColor{
        return UIColor(red: 102/255, green: 255/255, blue: 204/255, alpha: 1.0)
    }
    
    public class func ice()->UIColor{
        return UIColor(red: 102/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func sky()->UIColor{
        return UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func orchild()->UIColor{
        return UIColor(red: 102/255, green: 102/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func lavendar()->UIColor{
        return UIColor(red: 204/255, green: 102/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func bubblegum()->UIColor{
        return UIColor(red: 255/255, green: 102/255, blue: 255/255, alpha: 1.0)
    }
    
    public class func carnation()->UIColor{
        return UIColor(red: 255/255, green: 111/255, blue: 207/255, alpha: 1.0)
    }
    
    //Other
    public class func gold()->UIColor{
        return UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1.0)
    }

    public class func tangerieLight()->UIColor{
        return UIColor(red: 255/255, green: 176/255, blue: 79/255, alpha: 1.0)
    }
    
    public class func lightDarkGreen()->UIColor{
        return UIColor(red: 145/255, green: 211/255, blue: 133/255, alpha: 1.0)
    }
}
