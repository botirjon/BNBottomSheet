//
//  BNBottomSheetTopHeaderView.swift
//  rubber-band-effect
//
//  Created by botirjon nasridinov on 10.01.2020.
//  Copyright © 2022 musapps. All rights reserved.
//

import Foundation
import UIKit

class BNBottomSheetTopHeaderView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView.init()
        view.backgroundColor = self.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        return view
    }()
    
    var view: UIView? {
        didSet {
            updateView(oldValue: oldValue, newValue: view)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _init()
    }
    
    private func _init() {
        clipsToBounds = true
        backgroundColor = .clear
        
        addSubview(backgroundView)
    }
    
    private func addConstraints() {
        backgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: UIScreen.main.bounds.width, height: 16)
    }
    
    override var backgroundColor: UIColor? {
        set {
            backgroundView.backgroundColor = newValue
        }
        get {
            return backgroundView.backgroundColor
        }
    }
    
    private func updateView(oldValue: UIView?, newValue: UIView?) {
        oldValue?.removeFromSuperview()
        if let view = newValue {
            addSubview(view)
            
            view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            view.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        }
    }
}
