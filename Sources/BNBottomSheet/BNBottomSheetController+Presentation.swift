//
//  BottomSheetController+Presentation.swift
//  rubber-band-effect
//
//  Created by botirjon nasridinov on 10.01.2020.
//  Copyright © 2022 musapps. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

extension BNBottomSheetController {
    
    public func close(completion: (() -> Void)? = nil) {
        hide(animated: true) {
            self.dismiss(animated: false, completion: {
                completion?()
            })
        }
    }
    
    
    func showWhileAppearing(completion: (() -> Void)? = nil) {
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            if context.presentationStyle == .overFullScreen && self.isBeingPresented {
                DispatchQueue.main.async {
                    AudioServicesPlaySystemSound(1520) //  `pop` feedback sound
                    self.show(animated: true)
                }
            }
        }, completion: { (_) in
            completion?()
        })
    }
    
    func show(animated: Bool = false, completion: (() -> Void)? = nil) {
        let h = tableViewHeight()
        tableViewVisibleHeight = h
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.overlayView.alpha = 1.0
                self.dragIndicator.alpha = 1.0
                self.view.layoutIfNeeded()
            }) { (_) in
                completion?()
            }
        }
        else {
            self.overlayView.alpha = 1.0
            self.dragIndicator.alpha = 1.0
            self.isTransitioning = false
            completion?()
        }
    }
    
    func hide(animated: Bool = false, completion: (() -> Void)? = nil) {
        tableViewVisibleHeight = 0
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                self.overlayView.alpha = 0
                self.dragIndicator.alpha = 0
                self.view.layoutIfNeeded()
            }) { (_) in
                completion?()
            }
        }
        else {
            self.tableViewVisibleHeight = 0
            self.overlayView.alpha = 0
            self.dragIndicator.alpha = 0
            completion?()
        }
    }
}
