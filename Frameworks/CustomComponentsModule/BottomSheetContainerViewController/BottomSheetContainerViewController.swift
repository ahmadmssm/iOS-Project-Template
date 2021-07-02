//
//  BottomSheetContainerViewController.swift
//  BottomSheet
//
//  Created by Zafar on 8/13/20.
//  Copyright © 2020 Zafar. All rights reserved.
//
// Ref: https://betterprogramming.pub/how-to-create-an-interactive-bottom-sheet-in-swift-5-adadaad79e72

import UIKit

open class BottomSheetContainerViewController<ParentViewController: UIViewController,
                                              BottomSheet: UIViewController>:
    UIViewController,
    UIGestureRecognizerDelegate {
    
    private let parentVC: ParentViewController
    private let bottomSheetVC: BottomSheet
    private let configurations: BottomSheetConfigs
    //
    private var state: BottomSheetState = .collapsed
    private var topConstraint = NSLayoutConstraint()
    private lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer()
        gesture.delegate = self
        gesture.addTarget(self, action: #selector(panGestureAction))
        return gesture
    }()
    
    public init(parentViewController: ParentViewController,
                bottomSheetViewController: BottomSheet,
                bottomSheetConfigs: BottomSheetConfigs) {
        self.parentVC = parentViewController
        self.bottomSheetVC = bottomSheetViewController
        self.configurations = bottomSheetConfigs
        super.init(nibName: nil, bundle: nil)
        self.setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configurations.maxHeight
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.state = .expanded
            })
        }
        else {
            self.view.layoutIfNeeded()
            self.state = .expanded
        }
    }
    
    public func hideBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configurations.minHeight
        if animated {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           options: [.curveEaseOut],
                           animations: {
                            self.view.layoutIfNeeded()
                           }, completion: { _ in
                            self.state = .collapsed
                           })
        }
        else {
            self.view.layoutIfNeeded()
            self.state = .collapsed
        }
    }
    
    @objc private func panGestureAction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: bottomSheetVC.view)
        let velocity = sender.velocity(in: bottomSheetVC.view)
        let yTranslationMagnitude = translation.y.magnitude
        switch sender.state {
        case .began, .changed:
            if self.state == .expanded {
                guard translation.y > 0 else { return }
                topConstraint.constant = -(configurations.maxHeight - yTranslationMagnitude)
                self.view.layoutIfNeeded()
            }
            else {
                let newConstant = -(configurations.minHeight + yTranslationMagnitude)
                guard translation.y < 0 else { return }
                guard newConstant.magnitude < configurations.maxHeight else {
                    self.showBottomSheet()
                    return
                }
                topConstraint.constant = newConstant
                self.view.layoutIfNeeded()
            }
        case .ended:
            if self.state == .expanded {
                if yTranslationMagnitude >= configurations.maxHeight / 2 || velocity.y > 1000 {
                    self.hideBottomSheet()
                }
                else {
                    self.showBottomSheet()
                }
            }
            else {
                if yTranslationMagnitude >= configurations.maxHeight / 2 || velocity.y < -1000 {
                    self.showBottomSheet()
                }
                else {
                    self.hideBottomSheet()
                }
            }
        case .failed:
            if self.state == .expanded {
                self.showBottomSheet()
            }
            else {
                self.hideBottomSheet()
            }
        default: break
        }
    }
    
    private func setupUI() {
        self.addChild(parentVC)
        self.addChild(bottomSheetVC)
        self.view.addSubview(parentVC.view)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.view.addGestureRecognizer(panGesture)
        parentVC.view.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetVC.view.translatesAutoresizingMaskIntoConstraints = false
        //
        NSLayoutConstraint.activate([
            parentVC.view.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            parentVC.view.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            parentVC.view.topAnchor
                .constraint(equalTo: self.view.topAnchor),
            parentVC.view.bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor)
        ])
        parentVC.didMove(toParent: self)
        topConstraint = bottomSheetVC.view.topAnchor
            .constraint(equalTo: self.view.bottomAnchor,
                        constant: -configurations.minHeight)
        NSLayoutConstraint.activate([
            bottomSheetVC.view.heightAnchor
                .constraint(equalToConstant: configurations.maxHeight),
            bottomSheetVC.view.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            bottomSheetVC.view.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            topConstraint
        ])
        bottomSheetVC.didMove(toParent: self)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
