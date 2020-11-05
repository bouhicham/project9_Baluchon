//
//  Alert.swift
//  LeBaluchon
//
//  Created by hicham on 19/10/2020.
//  Copyright © 2020 hicham. All rights reserved.
//
import UIKit


extension UIViewController {
// Display an alert with the message of our choices
 func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}
    func presentAlert(message:String){
        let alertVC = UIAlertController(title: "Error", message: "The error for message", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
