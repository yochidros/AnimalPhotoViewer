//
//  PresentCardAnimator.swift
//  AnimalPhotoViewer
//
//  Created by Yoshiki Miyazawa on 2019/07/05.
//  Copyright © 2019 yochidros. All rights reserved.
//

import UIKit

final class PresentCardAnimator: NSObject {
    struct Params {
        let fromCardFrame: CGRect
        let fromCell: CardTransitionableCell
    }
//
//    private let params: Params
//    private let presentAnimationDuration: TimeInterval
//    private let springAnimator: UIViewPropertyAnimator
}

final class PresentCardTransitionDriver {
//    
//    let animator: UIViewPropertyAnimator
//    init(params: PresentCardAnimator.Params, transitionContext: UIViewControllerContextTransitioning, baseAnimator: UIViewPropertyAnimator) {
//        let ctx = transitionContext
//        let container = ctx.containerView
//        let screens: (from: UIViewController?, to: UIViewController?) = ( ctx.viewController(forKey: .from), ctx.viewController(forKey: .to))
//
//        guard let cardDetailView = ctx.view(forKey: .to) else { return }
//
//        let fromCardFrame = params.fromCardFrame
//
//        let animatedContainerView = UIView()
//
//        animatedContainerView.translatesAutoresizingMaskIntoConstraints = false
//        container.addSubview(animatedContainerView)
//
//        do {
//            let animatedContainerConstraints = [
//                animatedContainerView.widthAnchor.constraint(equalToConstant: container.bounds.width),
//                animatedContainerView.heightAnchor.constraint(equalToConstant: container.bounds.height),
//                animatedContainerView.centerXAnchor.constraint(equalTo: container.centerXAnchor)
//            ]
//            NSLayoutConstraint.activate(animatedContainerConstraints)
//        }
//
//        let animatedContainerVerticalConstraint: NSLayoutConstraint = animatedContainerView.centerYAnchor.constraint(
//            equalTo: container.centerYAnchor,
//            constant: (fromCardFrame.height/2 + fromCardFrame.minY) - container.bounds.height/2
//        )
//        animatedContainerVerticalConstraint.isActive = true
//
//        animatedContainerView.addSubview(cardDetailView)
//        cardDetailView.translatesAutoresizingMaskIntoConstraints = false
//
//        let weirdCardToAnimatedContainerTopAnchor: NSLayoutConstraint
//
//        do {
//            let verticalAnchor: NSLayoutConstraint = cardDetailView.centerYAnchor.constraint(equalTo: animatedContainerView.centerYAnchor)
//            let cardConstraints = [
//                verticalAnchor,
//                cardDetailView.centerXAnchor.constraint(equalTo: animatedContainerView.centerXAnchor)
//            ]
//            NSLayoutConstraint.activate(cardConstraints)
//        }
//
//        let cardWidthConstraint = cardDetailView.widthAnchor.constraint(equalToConstant: fromCardFrame.width)
//        let cardHeightConstraint = cardDetailView.heightAnchor.constraint(equalToConstant: fromCardFrame.height)
//
//        NSLayoutConstraint.activate([cardWidthConstraint, cardHeightConstraint])
//
//
//
//        params.fromCell.resetTransform()
//
//    }
}
