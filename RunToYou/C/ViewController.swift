//
//  ViewController.swift
//  RunToYou
//
//  Created by 이정환 on 4/22/24.
//

import UIKit

final class ViewController: UIViewController {

    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
   
}
