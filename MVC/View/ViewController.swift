//
//  ViewController.swift
//  MoyaTest
//
//  Created by belga on 10/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {
  
  var photos: [PhotoType] = [] {
    didSet {
      refreshDisplay()
    }
  }
		
  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let service = PhotoModel()
    service.listPhotos({ (result) in
      self.photos = result
    }) { (error) in
      let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
      self.present(alertVC, animated: true, completion: nil)
    }
  }

  func refreshDisplay() {
    tableView.reloadData()
  }
}


extension ViewController : UITableViewDataSource {
  
  
  func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    
    return self.photos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! TableViewCell
    cell.photo = self.photos[indexPath.row]
    return cell
  }
  
}

extension ViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row<photos.count  {
      let  detailVC : DetailPhotoViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailPhoto") as! DetailPhotoViewController
      detailVC.id = self.photos[indexPath.row].id
      self.navigationController?.pushViewController(detailVC, animated: true)
      self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
  }
}

