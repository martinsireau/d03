//
//  MyCollectionViewController.swift
//  d03
//
//  Created by Martin SIREAU on 05/10/2017.
//  Copyright © 2017 Martin SIREAU. All rights reserved.
//

import UIKit

class MyCollectionViewController: UICollectionViewController {

    let urlStringArr = [
        "https://sd-cdn.fr/wp-content/uploads/2017/07/nasa.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/discover_missions_banner.jpg",
//        "https://img.20mn.fr/plJkjkC-TJmJVWp2MyM5TQ/1200x768_nasa-annonce-importante-faire",
        "https://cdn0.tnwcdn.com/wp-content/blogs.dir/1/files/2015/07/NASA.jpg",
        "https://resize1-parismatch.ladmedia.fr/img/var/news/storage/images/paris-match/actu/sciences/la-nasa-decouvre-1284-planetes-et-peut-etre-une-terre-kepler-965740/13670101-1-fre-FR/La-Nasa-decouvre-1284-planetes-et-peut-etre-une-Terre.jpg",
        "https://resize3-parismatch.ladmedia.fr/img/var/news/storage/images/paris-match/vivre/high-tech/voila-le-successeur-du-concorde-lockheed-martin-nasa-922587/13151913-1-fre-FR/Voila-le-successeur-du-Concorde.jpg",
        "https://resize2-parismatch.ladmedia.fr/img/var/news/storage/images/paris-match/actu/sciences/exoplanetes-la-conference-de-presse-surprise-de-la-nasa-1193762/20273048-1-fre-FR/Exoplanetes-La-conference-de-presse-surprise-de-la-NASA.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia21499-20170523.jpg",
        "https://sd-cdn.fr/wp-content/uploads/2017/07/nasa.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/discover_missions_banner.jpg",
        "https://img.20mn.fr/plJkjkC-TJmJVWp2MyM5TQ/1200x768_nasa-annonce-importante-faire",
        "https://cdn0.tnwcdn.com/wp-content/blogs.dir/1/files/2015/07/NASA.jpg",
        "https://resize1-parismatch.ladmedia.fr/img/var/news/storage/images/paris-match/actu/sciences/la-nasa-decouvre-1284-planetes-et-peut-etre-une-terre-kepler-965740/13670101-1-fre-FR/La-Nasa-decouvre-1284-planetes-et-peut-etre-une-Terre.jpg",
        "https://resize3-parismatch.ladmedia.fr/img/var/news/storage/images/paris-match/vivre/high-tech/voila-le-successeur-du-concorde-lockheed-martin-nasa-922587/13151913-1-fre-FR/Voila-le-successeur-du-Concorde.jpg",
        "https://resize2-parismatch.ladmedia.fr/img/var/news/storage/images/paris-match/actu/sciences/exoplanetes-la-conference-de-presse-surprise-de-la-nasa-1193762/20273048-1-fre-FR/Exoplanetes-La-conference-de-presse-surprise-de-la-NASA.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia21499-20170523.jpg",
        "mabite", "ldjfhgsj"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlStringArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MyViewControllerID") as! MyViewController
        destination.imageURL = URL(string: urlStringArr[indexPath.row])
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
        
        cell.backgroundColor = .black
        if let url = URL(string: urlStringArr[indexPath.row]) {
            cell.spinningWheel.startAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            DispatchQueue.global(qos: .userInteractive).async {
                let lastImageURL = url
                if url == lastImageURL {
                    if let imageData = NSData(contentsOf: url){
                        DispatchQueue.main.async { [weak weakSelf = cell] in
                            weakSelf?.imageView.image = UIImage(data: imageData as Data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            cell.spinningWheel.stopAnimating()
                        }
                    } else {
                        DispatchQueue.main.async { [weak weakSelf = cell] in
                            weakSelf?.imageView.image = nil
                            self.urlInvalid(whichUrl: self.urlStringArr[indexPath.row])
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func urlInvalid(whichUrl: String){
        let alert = UIAlertController(title: "Error", message: "Cannot acces to \(whichUrl)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
