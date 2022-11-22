//
//  BaseViewController.swift
//  BreakingBad
//
//  Created by Alihan KUZUCUK on 22.11.2022.
//

import UIKit
import MaterialActivityIndicator
import SwiftAlertView

class BaseViewController: UIViewController {
    
    let indicator = MaterialActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
    }
    
    private func setupActivityIndicatorView() {
        view.addSubview(indicator)
        setupActivityIndicatorViewConstraints()
    }
    
    private func setupActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showAlertView(title: String, message: String, completion: @escaping() -> Void) {
        SwiftAlertView.show(title: title,
                            message: message,
                            buttonTitles: ["OK"]).onButtonClicked { _, _ in
            completion()
        }
    }
    
}
