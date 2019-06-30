//
//  PreviewViewController.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import UIKit
import API

class PreviewViewController: UIViewController {

  @IBOutlet weak var previewView: UIImageView?
  private var image: ItemResponse?
  
  init(image: ItemResponse) {
    self.image = image
    super.init(nibName: PreviewViewController.className, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.largeTitleDisplayMode = .never
    self.showImage()
  }

  private func showImage() {
    guard let image = self.image else { return }
    ImageLoader.loadImage(url: image.largeImageURL, into: previewView)
  }

}

extension UIView {
  func showLoading() {
    if self.subviews.contains(where: { $0.tag == 100 }), let view = self.subviews.first(where: { $0.tag == 100 }) {
      view.removeFromSuperview()
    }
    let indicator = UIActivityIndicatorView(style: .whiteLarge)
    indicator.frame = CGRect(origin: .zero, size: CGSize(width: 60, height: 60))
    indicator.color = UIColor.blue
    indicator.tag = 100
    self.addSubview(indicator)
    indicator.startAnimating()
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.bringSubviewToFront(indicator)
  }
  
  func hideLoadingView() {
    if self.subviews.contains(where: { $0.tag == 100 }), let view = self.subviews.first(where: { $0.tag == 100 }) {
      view.removeFromSuperview()
    }
  }
}
