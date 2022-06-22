//
//  BNBottomSheetController.swift
//  rubber-band-effect
//
//  Created by botirjon nasridinov on 10.01.2020.
//  Copyright © 2022 musapps. All rights reserved.
//

import Foundation
import UIKit


public class BNBottomSheetController: UIViewController, BNBottomSheetViewInstaller {
    
    var tableViewPan: UIPanGestureRecognizer!
    
    // subviews
    var tableView: UITableView!
    var overlayView: UIView!
    var dragIndicator: UIView!
    var contentBackgroundView: UIView!
    
    // delegates
    var tableViewDelegate: UITableViewDelegate! { self }
    var tableViewDataSource: UITableViewDataSource! { self }
    var tableViewPanDelegate: UIGestureRecognizerDelegate! { self }
    
    var tableViewHeightConstraint: NSLayoutConstraint!
    var tableViewTopConstraint: NSLayoutConstraint!
    
    var dragTarget: Any? { self }
    var dragHandler: Selector? { #selector(dragged(_:)) }
    
    var tableViewNormalHeight: CGFloat = 0
    var bottomPatchOffset: CGFloat = 16
    
    public var info: Any?
    
    var mainView: UIView { view }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _init()
    }
    
    private func _init() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
        
        reusableCells.forEach { (identifier, cellClass) in
            self.tableView.register(cellClass, forCellReuseIdentifier: identifier)
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(overlayViewTapped))
        overlayView.addGestureRecognizer(tap)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isTransitioning = true
        if animated {
            self.showWhileAppearing {
                self.isTransitioning = false
                if self.viewDidLayout {
                    self.layoutOnce()
                }
                self.viewReadyForInteractions = true
            }
        }
        else {
            self.show(animated: animated, completion: {
                self.isTransitioning = false
                if self.viewDidLayout {
                    self.layoutOnce()
                }
                self.viewReadyForInteractions = true
            })
        }
        localizeTexts()
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !viewDidLayout {
            layoutOnce()
            viewDidLayout = true
        }
    }
    
    private func layoutOnce() {
        let h = tableViewHeight()
        tableViewHeightConstraint.constant = h
        if !isTransitioning {
            tableViewVisibleHeight = h
        }
        tableViewNormalHeight = h
        tableViewTotalHeight = h
        
        dragIndicator.isHidden = h != tableViewMaximumHeight()
        isScrollEnabled = h == tableViewMaximumHeight()
    }
    
    
    /// - TAG: Public interface
    public var delegate: BNBottomSheetDelegate?
    public var dataSource: BNBottomSheetDataSource?
    public var autoClosesWhenItemSelected: Bool = false
    
    // private
    
    var viewDidLayout: Bool = false
    var viewReadyForInteractions: Bool = false
    
    var tableViewVisibleHeight: CGFloat = 0 {
        didSet {
            tableViewTopConstraint.constant = -(tableViewVisibleHeight-bottomPatchOffset)
        }
    }
    
    var tableViewTotalHeight: CGFloat = 0
    let topMargin: CGFloat = 80
    let dismissVelocityThreashold: CGFloat = 1162
    var recentPanTouchPoint: CGPoint = .zero
    
    var isTransitioning: Bool = false
    var isScrollEnabled: Bool {
        set {
            tableView.isScrollEnabled = newValue
        }
        get {
            return tableView.isScrollEnabled
        }
    }
    
    var reusableCells: [String: AnyClass] = [:]
    
    public func reloadData() {
        layoutOnce()
        self.tableView.reloadData()
    }
}

extension BNBottomSheetController: UIGestureRecognizerDelegate {
    
    @objc func overlayViewTapped() {
        close {
            self.delegate?.bottomSheetControllerDidCancel(self)
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer == tableViewPan
    }
    
    @objc private func dragged(_ sender: UIPanGestureRecognizer) {
        guard viewReadyForInteractions else {
            return
        }
        
        let translation = sender.translation(in: view).y
        
        if tableViewNormalHeight < tableViewMaximumHeight() {
            
            if tableViewVisibleHeight >= tableViewNormalHeight {
                tableViewTotalHeight -= translation
                tableViewVisibleHeight = logarithmicHeight(forHeight: tableViewTotalHeight)
                
                if sender.state == .ended {
                    restoreTableViewHeight()
                }
            }
            else {
                tableViewVisibleHeight -= translation
            }
            if sender.state == .ended {
                draggingEnded(withVelocity: sender.velocity(in: view).y)
            }
            sender.setTranslation(.zero, in: view)
        }
        else {
            
            if sender.view == overlayView || sender.view == dragIndicator {
                let proposedHeight = tableViewVisibleHeight - translation
                if proposedHeight <= tableViewNormalHeight {
                    tableViewVisibleHeight = proposedHeight
                    if sender.state == .ended {
                        draggingEnded(withVelocity: sender.velocity(in: view).y)
                    }
                    sender.setTranslation(.zero, in: view)
                }
            }
        }
    }
    
    private func logarithmicHeight(forHeight height: CGFloat) -> CGFloat {
        return tableViewNormalHeight * (1 + log10(height/tableViewNormalHeight))
    }
    
    private func restoreTableViewHeight() {
        tableViewVisibleHeight = tableViewNormalHeight
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIView.AnimationOptions.allowUserInteraction, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.tableViewTotalHeight = self.tableViewNormalHeight
            if self.tableViewNormalHeight == self.tableViewMaximumHeight() {
                self.tableView.isScrollEnabled = true
            }
        })
    }
    
    private func draggingEnded(withVelocity velocity: CGFloat? = nil) {
        if (velocity != nil && velocity! >= dismissVelocityThreashold) || tableViewVisibleHeight <= (2/3)*tableViewNormalHeight {
            close {
                self.delegate?.bottomSheetControllerDidCancel(self)
            }
        }
        else {
            restoreTableViewHeight()
        }
    }
}
