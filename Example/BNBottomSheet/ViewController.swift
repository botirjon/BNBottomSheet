//
//  ViewController.swift
//  BNBottomSheet
//
//  Created by botirjon on 02/12/2023.
//  Copyright (c) 2023 botirjon. All rights reserved.
//

import UIKit
import BNBottomSheet
import UIKit

class ViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Open", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: button.superview!.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: button.superview!.centerYAnchor)
        ])
    }
    
    @objc private func buttonTapped() {
        let bottomSheet = BNBottomSheetController()
        bottomSheet.dataSource = self
        bottomSheet.delegate = self
        if #available(iOS 13.0, *) {
            bottomSheet.styles.contentBackgroundColor = .init(dynamicProvider: { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? .white : .gray
            })
        } else {
            bottomSheet.styles.contentBackgroundColor = .green
        }
        present(bottomSheet, animated: true)
    }
    
    private let items: [String] = [
        "Apple",
        "Orange",
        "Banana"
    ]
}


extension ViewController: BNBottomSheetDataSource {
    func numberOfSections(in bottomSheetController: BNBottomSheetController) -> Int {
        return 1
    }
    
    func bottomSheetController(_ controller: BNBottomSheetController, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func bottomSheetController(_ controller: BNBottomSheetController, cellForItemAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .systemBlue
        cell.textLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        return cell
    }
}

extension ViewController: BNBottomSheetDelegate {
    func bottomSheetController(_ controller: BNBottomSheetController, heightForItemAt indexPath: IndexPath) -> CGFloat {
        max(UITableView.automaticDimension, 46)
    }
}
