//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Echo Wang on 8/25/19.
//  Copyright © 2019 Echo Wang Studio. All rights reserved.
//

import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {

    
    @IBOutlet weak var spinner: UIActivityIndicatorView!{
        didSet {
            spinner.isHidden = true
        }
    }
    
    // dropZone and emojiArtView are separate:
    // track the url at controller level not view level
    // emojiArtView might be scrolled to very small 
    @IBOutlet weak var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        // NSURL.self specify the class
        // something is both an image and the URL for the image
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    var imageFetcher: ImageFetcher!
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                self.emojiArtView.backgroundImage = image
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
            }
        }
        spinner.startAnimating()
        self.spinner.isHidden = false
        // when user open the document, fetch the background image by Internet instead of storing image in document
        // a drag can have multiple urls
        session.loadObjects(ofClass: NSURL.self){ nsurls in
            // the type of nsurls is NS item provider
            // as? this is a nsurl and we want a url
            if let url = nsurls.first as? URL {
                self.imageFetcher.fetch(url)
            }
        }
        // when fetch fails, use backup image
        session.loadObjects(ofClass: UIImage.self){ images in
            if let image = images.first as? UIImage{
                self.imageFetcher.backup = image
            }
        }
    }
    
    @IBOutlet weak var emojiArtView: EmojiArtView!
}
