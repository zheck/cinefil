//
//  StringExtension.swift
//  cinefil
//
//  Created by zhou on 2/16/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import Foundation

extension String {

    func sha1Encode() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)

        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let sha1 = NSData(bytes: digest, length: digest.count)

        return sha1.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }

}
