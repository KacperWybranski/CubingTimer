//
//  TransparentNavigationController.swift
//  CubingTimer
//
//  Created by test on 24/06/2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class TransparentNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
}
