//
//  ViewInstaller.swift
//  BNBottomSheet
//
//  Created by Botirjon Nasridinov on 22/06/22.
//

import UIKit.UIView

protocol ViewInstaller: AnyObject {
    /// The parent (root) view of all subviews
    var mainView: UIView { get }
    
    /// Additional parameter to setup subviews
    var parameter: Any? { get }
    
    /// Initializes, then embeds subviews. Finally, adds constraints of subviews
    func installSubviews()
    
    /// Initializes all subview elements
    func initSubviews()
    
    /// Places each subview to its super-view
    func addSubviews()
    
    /// Adds constraints of placed subviews
    func addSubviewConstraints()
    
    /// Localizes all texts that should be translated into local langugage
    func localizeTexts()
    
    var safeAreaInsets: UIEdgeInsets { get }
}


extension ViewInstaller {
    
    var parameter: Any? { nil }
    var safeAreaInsets: UIEdgeInsets { .zero }
    
    func installSubviews() {
        initSubviews()
        addSubviews()
        addSubviewConstraints()
    }
    
    func initSubviews() {
        fatalError("\(#function) implementation is required!")
    }
    
    func addSubviews() {
        fatalError("\(#function) implementation is required!")
    }
    
    func addSubviewConstraints() {
        fatalError("\(#function) implementation is required!")
    }
    
    func localizeTexts() {
        
    }
}

