//
//  MyViewController.swift
//  d03
//
//  Created by Martin SIREAU on 05/10/2017.
//  Copyright © 2017 Martin SIREAU. All rights reserved.
//

import UIKit

class MyViewController: UIViewController, UIScrollViewDelegate {

    var imageURL : URL? {
        didSet {
            fetchImage()
        }
    }
    
    private func fetchImage(){
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                self.imageView.image = UIImage(data: imageData as Data)
                self.imageView.sizeToFit()
            }
        }
    }
    
    private var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = scrollView.bounds.size.width / imageView.bounds.size.width
            scrollView.maximumZoomScale = 2.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Scroll View"
        
        if imageView.image == nil {
            let alert = UIAlertController(title: "Error", message: "Cannot acces to that UR)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }


}
