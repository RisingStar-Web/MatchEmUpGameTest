//
//  StartViewController.swift
//  MatchEmUpGameTest
//
//  Created by Alex Suvorov on 3/5/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    
    
    @IBOutlet weak var startGameButton: UIButton! {
        didSet {
            
            
            startGameButton.layer.shadowColor = UIColor.black.cgColor
            startGameButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            startGameButton.layer.shadowOpacity = 2.0
            startGameButton.layer.shadowRadius = 2.0
            
            startGameButton.layer.cornerRadius = 10
            startGameButton.backgroundColor = UIColor(hue: 199/360, saturation: 75/100, brightness: 76/100, alpha: 1.0)
        }
    }
    
    
    @IBOutlet weak var resetButton: UIButton! {
        
        didSet {
            resetButton.layer.shadowColor = UIColor.black.cgColor
            resetButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            resetButton.layer.shadowOpacity = 2.0
            resetButton.layer.shadowRadius = 2.0
            
            resetButton.layer.cornerRadius = 10
            resetButton.backgroundColor = UIColor(hue: 199/360, saturation: 75/100, brightness: 76/100, alpha: 1.0)
            
           resetButton.isHidden = true
            
            
         
        }
        
    }
    
    
    @IBAction func resetButtonDidTap(_ sender: Any) {
        let alert = UIAlertController(title: "Reset progresss", message: "Are you sure you want to reset your progress??", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [] (_) in
            
            UserDefaults.standard.set(nil, forKey: "level")
            UserDefaults.standard.synchronize()
            self.resetButton.isHidden = true
            self.startGameButton.setTitle("Start Game", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let _ = UserDefaults.standard.object(forKey: "level") {
            resetButton.isHidden = false
            startGameButton.setTitle("Continue...", for: .normal)
        } else {
            resetButton.isHidden = true
            startGameButton.setTitle("Start Game", for: .normal)
        }
    }
    

  

}
