//
//  ViewController.swift
//  TwitterLikeProfileView
//
//  Created by Teruki Nakano on 2018/10/11.
//  Copyright © 2018 Teruki Nakano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         navigationController?.setNavigationBarHidden(true, animated: true)
    }


}

