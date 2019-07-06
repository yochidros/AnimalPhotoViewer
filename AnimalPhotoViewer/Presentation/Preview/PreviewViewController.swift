//
//  PreviewViewController.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import UIKit
import Models
import AVFoundation

class PreviewViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView?
  
  @IBOutlet weak var previewView: UIImageView?
  private var image: ImageResponse?
  var gestureRecognizer: UITapGestureRecognizer?
  
  
  init(image: ImageResponse) {
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
    prepareView()
  }
  
  private func prepareView() {
    self.scrollView?.delegate = self
    
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapped))
    tapGesture.numberOfTapsRequired = 2
    scrollView?.addGestureRecognizer(tapGesture)
    self.gestureRecognizer = tapGesture
  }

  private func showImage() {
    guard let image = self.image else { return }
    ImageLoader.loadImage(url: image.largeImageURL, into: previewView)
  }
  
  @objc func handleDoubleTapped() {
    if scrollView?.zoomScale != 1 {
      scrollView?.setZoomScale(1, animated: true)
    } else {
      scrollView?.setZoomScale(3, animated: true)
    }
  }

}


extension PreviewViewController: UIScrollViewDelegate {

  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.previewView
  }

}
