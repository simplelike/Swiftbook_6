//
//  FirstScreenViewController.swift
//  Swiftbook_2
//
//  Created by Andrey Borovilov on 18/02/2020.
//  Copyright © 2020 Andrey Borovilov. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    var color:UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.color = color
        vc.delegate = self
    }
}

extension FirstScreenViewController:changeColorDelegate{
    func changeColor(color: UIColor) {
        self.color = color
    }
    
    
}
