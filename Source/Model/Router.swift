//
//  Router.swift
//  PerpTestTask
//
//  Created by Yurii Tsymbala on 1/17/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit

class Router {
  func showAlert(_ alertViewModel: AlertViewModel, inViewController: UIViewController) {
    let alert = UIAlertController(title: alertViewModel.title,
                                  message: alertViewModel.message,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    inViewController.present(alert, animated: true, completion: nil)
  }
}

