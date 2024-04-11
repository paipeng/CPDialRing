//
//  ViewController.swift
//  ialRing
//
//  Created by Pai Peng on 04/07/2024.
//  Copyright (c) 2024 Pai Peng. All rights reserved.
//

import UIKit
import CPDialRing

class ViewController: UIViewController {
    @IBOutlet weak var dialRing: CPDialRing!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dialRing = CPDialRing(frame:CGRectMake(self.view.frame.size.width - 100,200, 100, 100), shutterSpeed: 1)
        dialRing.layer.borderColor = UIColor.green.cgColor
        dialRing.layer.borderWidth = 0
        
        self.view.addSubview(dialRing)
        
        dialRing.setDelegate(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: CPDialRingDelegate {
    func speed(shutterSpeed: CGFloat) {
        print("shutterSpeed: \(shutterSpeed)")
    }
    
}


