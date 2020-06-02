//
//  ViewController.swift
//  taskQuizApp01
//
//  Created by 福島悠樹 on 2020/05/30.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tappedStartBtn(_ sender: Any) {
        let vc = FirstQuestionViewController()
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

