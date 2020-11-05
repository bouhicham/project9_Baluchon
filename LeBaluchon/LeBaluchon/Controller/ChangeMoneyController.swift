//
//  ChangeMoneyController.swift
//  LeBaluchon
//
//  Created by hicham on 08/06/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation
import UIKit


class ChangeMoneyController: UIViewController, UITextFieldDelegate   {
    
    // MARK: - Outlets
    @IBOutlet weak var resultMoney: UILabel!
    @IBOutlet weak var textMoney: UITextField!
    @IBOutlet weak var changePick: UIPickerView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    
    // instance
    let changeService = ChangeService()
    var activeCurrency:Double = 0;
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        addShaddowToChangeLabel()
        tappedChangeButton()
        changeButton.layer.shadowColor = UIColor.black.cgColor
        changeButton.layer.shadowOpacity = 0.5
        changeButton.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        changeButton.layer.shadowRadius = 8
        changeButton.clipsToBounds = true
        changeButton.layer.masksToBounds = false
    }
    
    // design backgroundColor
    private func addShaddowToChangeLabel(){
        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named:"BB")!)
    }
    
    //button
    @IBAction func pressedButtonChange(_ sender: Any) {
        tappedChangeButton()
    }
    
    func calculCurrency() {
        DispatchQueue.main.async {
            if  self.textMoney.text != "" {
                var total: Double = 0
                self.resultMoney.text = String(Double(self.textMoney.text!)! * self.activeCurrency)
                guard let textMoney = self.textMoney.text else {return}
                guard let result = Double(textMoney) else {return}
                total = result * self.activeCurrency
                self.resultMoney.text = String(format: "%.2f", total)
                
            }
        }
    }
    
    
    private func displayScreen(result: Double){
        let result = String(format: "%.2f", result)
        self.resultMoney.text = result
    }
    // Function to shown the loading interface
    private func toggleActivityIndicator(shown: Bool) {
        changeButton.isHidden = shown
        loader.isHidden = !shown
    }
    // network call
    private  func tappedChangeButton() {
        toggleActivityIndicator(shown: true)
        changeService.getChange { (result,currency)  in
            self.toggleActivityIndicator(shown: false)
            
            DispatchQueue.main.async {
                
                if result , let _ = currency {
                    self.calculCurrency()
                    self.changePick.reloadAllComponents()
                }else {
                    self.showAlert(title:"",message: "erreur")
                    
                }
            }
        }
    }
    
    @IBAction func dismisskeyboard(_ sender: UITapGestureRecognizer) {
        self.textMoney.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textMoney.resignFirstResponder()
        return true
    }
    
}

extension ChangeMoneyController:  UIPickerViewDelegate, UIPickerViewDataSource {
    // Number of component of the pickers: 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // Number of elements: count on language
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return changeService.myCurrency.count
    }
    // Text: the description of each currency
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return changeService.myCurrency[row]
    }
    // When the user select a row, we send this row to the model.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = changeService.myValues[row]
    }
}
