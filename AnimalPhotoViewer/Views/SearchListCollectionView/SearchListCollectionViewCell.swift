//
//  SearchListCollectionViewCell.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import UIKit


class SearchListCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    self.prepare()
  }
  
  private func prepare() {
    self.layer.cornerRadius = 8
    self.clipsToBounds = true
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowRadius = 8
    self.layer.shadowOpacity = 1
    self.layer.shadowOffset = CGSize(width: 0, height: 10)
    self.layer.masksToBounds = true
  }

  func configure(imageURL: String) {
    self.imageView?.layer.cornerRadius = 8
    self.imageView?.clipsToBounds = true
    ImageLoader.loadImage(url: imageURL, into: self.imageView)
  }

}
