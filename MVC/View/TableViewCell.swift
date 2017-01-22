//
//  TableViewCell.swift
//  MoyaTest
//
//  Created by belga on 14/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import UIKit
import AlamofireImage

class TableViewCell: UITableViewCell {

  @IBOutlet var title: UILabel!
  
  @IBOutlet var thumbnailImageView: UIImageView!
  
  @IBOutlet var date: UILabel!
  
  
  var photo: PhotoType? {
    didSet {
      if let photo = photo {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        title.text = photo.title ?? ""
        if let photoDate = photo.date {
          date.text = formatter.string(from: photoDate)
        }
        if let thumbnailUrl = photo.thumbnailUrl,
          let url =  URL(string: thumbnailUrl){
          thumbnailImageView.af_setImage(withURL: url)
        }
        
        
      } else {
        title.text = "Unknown"
        date.text = "Unknown"
      }
    }
  }

}
