//
//  FileManager.swift
//  cinefil
//
//  Created by zhou on 2/15/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

class FileManager: NSObject {

    class func getApiKey(fileName: String) -> String {
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: .None)
        do {
            let fileContent = try NSString(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding)
            return fileContent.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        } catch {
            return fileName
        }
    }

}
