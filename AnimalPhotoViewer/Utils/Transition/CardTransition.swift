//
//  CardTransition.swift
//  AnimalPhotoViewer
//
//  Created by Yoshiki Miyazawa on 2019/07/05.
//  Copyright © 2019 yochidros. All rights reserved.
//

import UIKit

protocol CardTransitionableCell {
    var isHidden: Bool { get set }
    func resetTransform()
}
final class CardTransition: NSObject, UIViewControllerTransitioningDelegate {
    struct Params {
        let fromCardFrame: CGRect
        let fromCardFrameWithoutTransform: CGRect
        let fromCell: CardTransitionableCell
    }
    
    let params: Params
    
    init(params: Params) {
        self.params = params
        super.init()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
