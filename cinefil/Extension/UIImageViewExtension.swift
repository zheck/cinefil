//
//  UIImageViewExtension.swift
//  cinefil
//
//  Created by zhou on 2/18/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {

    func setMovieDbImage(name: String?) {
        guard name != nil else { return }

        if let url = MovieDBService.instance.imageUrl(.Small, name: name!) {
            self.af_setImageWithURL(url)
        }
    }

}

