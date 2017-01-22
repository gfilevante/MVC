//
//  DetailPhotoViewController.swift
//  MoyaTest
//
//  Created by belga on 15/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {
  var id: Int = 0
  @IBOutlet var photoTitle: UILabel!
  @IBOutlet var photoDate: UILabel!
  @IBOutlet var photoImageView: UIImageView!
  var model : PhotoModelType?
  
  var photo: PhotoType? = nil {
     didSet {
      self.refreshDisplay()
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        model = PhotoModel()
        model?.getPhoto(id: id, success: { (result) in
          self.photo = result
        }, fail: { (error) in
          self.errorReceived(error:error)
        })
      
    }

  func refreshDisplay() {
    if let photo = self.photo {
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "es_ES")
      formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
      
      photoTitle.text = photo.title ?? ""
      if let date = photo.date {
        photoDate.text = formatter.string(from: date)
      }
      
      if let photoUrl = photo.url,
        let url =  URL(string: photoUrl) {
          photoImageView.af_setImage(withURL:url)
      }
      self.view.layoutIfNeeded()
    }
  }
  
  func errorReceived( error: Swift.Error) {
    let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    self.present(alertVC, animated: true, completion: nil)
  }



}
