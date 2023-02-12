//
//  BNBottomSheetViewInstaller.swift
//  AppUI
//
//  Created by botirjon nasridinov on 13.01.2020.
//  Copyright © 2022 musapps. All rights reserved.
//

import Foundation
import UIKit

internal protocol BNBottomSheetViewInstaller: ViewInstaller {
    
    var tableView: UITableView! { get set }
    var overlayView: UIView! { get set }
    var dragIndicator: UIView! { get set }
    var contentBackgroundView: UIView! { get set }
    
    var tableViewHeightConstraint: NSLayoutConstraint! { get set }
    var tableViewTopConstraint: NSLayoutConstraint! { get set }
    var tableViewPan: UIPanGestureRecognizer! { get set }
    
    var tableViewDelegate: UITableViewDelegate! { get }
    var tableViewDataSource: UITableViewDataSource! { get }
    var tableViewPanDelegate: UIGestureRecognizerDelegate! { get }
    var dragTarget: Any? { get }
    var dragHandler: Selector? { get }
    
    var tableViewNormalHeight: CGFloat { get set }
    var bottomPatchOffset: CGFloat { get set }
    
    var styles: BNBottomSheetController.Styles { get }
}

internal extension BNBottomSheetViewInstaller {
    
    func initSubviews() {
        //
        tableView = UITableView.init()
        tableView.layer.cornerRadius = 16
        tableView.clipsToBounds = true
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        var pan = UIPanGestureRecognizer.init(target: dragTarget, action: dragHandler)
        pan.delegate = tableViewPanDelegate
        tableViewPan = pan
        tableView.addGestureRecognizer(pan)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        
        //
        overlayView = UIView.init()
        overlayView.backgroundColor = styles.dragIndicatorColor
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.isUserInteractionEnabled = true
        pan = UIPanGestureRecognizer.init(target: dragTarget, action: dragHandler)
        overlayView.addGestureRecognizer(pan)
        overlayView.alpha = 0
        
        //
        dragIndicator = UIView.init()
        dragIndicator.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        dragIndicator.layer.cornerRadius = 2
        dragIndicator.translatesAutoresizingMaskIntoConstraints = false
        dragIndicator.isUserInteractionEnabled = true
        pan = UIPanGestureRecognizer.init(target: dragTarget, action: dragHandler)
        dragIndicator.addGestureRecognizer(pan)
            
        //
        contentBackgroundView = UIView.init()
        
        contentBackgroundView.backgroundColor = styles.contentBackgroundColor
        contentBackgroundView.layer.cornerRadius = 16
        contentBackgroundView.clipsToBounds = true
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews() {
        mainView.addSubview(overlayView)
        mainView.addSubview(contentBackgroundView)
        mainView.addSubview(tableView)
        mainView.addSubview(dragIndicator)
    }
    
    func addSubviewConstraints() {
        
        overlayView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        overlayView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        overlayView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        
        tableView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -0)
        tableViewTopConstraint.isActive = true
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: tableViewNormalHeight)
        tableViewHeightConstraint.isActive = true
        
        contentBackgroundView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        contentBackgroundView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        contentBackgroundView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: bottomPatchOffset).isActive = true
        contentBackgroundView.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        
        dragIndicator.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -(44-4)/2).isActive = true
        dragIndicator.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        dragIndicator.widthAnchor.constraint(equalToConstant: 44).isActive = true
        dragIndicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    func localizeTexts() {
        
    }
}
