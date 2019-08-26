//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by Echo Wang on 8/25/19.
//  Copyright © 2019 Echo Wang Studio. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {

    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }

}
