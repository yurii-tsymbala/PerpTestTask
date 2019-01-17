//
//  MainViewController.swift
//  PerpTestTask
//
//  Created by Yurii Tsymbala on 1/17/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
  @IBOutlet weak private var yearPickerView: UIPickerView!
  private var viewModel: MainViewModelType!
  private let disposeBag = DisposeBag()
  private var router: Router!

  convenience init(withViewModel viewModel: MainViewModelType,withRouter router: Router) {
    self.init()
    self.router = router
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchData()
  }
}
