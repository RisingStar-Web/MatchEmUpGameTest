//
//  ViewController+showAlert.swift
//  MatchEmUpGameTest


import UIKit


extension UIViewController {
    func showAlertOk(_ withTitle:String?, andText:String?) {
        let alert = UIAlertController(title: withTitle, message: andText, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(_ withTitle:String?, andText:String?, buttonTitle: String) {
        let alert = UIAlertController(title: withTitle, message: andText, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
