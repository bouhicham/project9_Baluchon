//
//  TranslateController.swift
//  Testing
//
//  Created by hicham on 27/05/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation
import UIKit

class TranslateController: UIViewController, UITextFieldDelegate  {
    
    // MARK: Outlets
    @IBOutlet weak var goTextTranslate: UITextField!
    @IBOutlet weak var resultTranslate: UITextField!
    @IBOutlet weak var goLanguage: UILabel!
    @IBOutlet weak var languageTranslate: UILabel!
   @IBOutlet weak var destiPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonTranslate: UIButton!
    @IBOutlet var back: UIView!
    
    // The destination language for translation
    private var goDestinationLanguage = TranslateService.shared.destinationLanguage
    private var index: Int = 0;
    
    // MARK: - Methods
    override func viewDidLoad() {
        
        super.viewDidLoad() //2
      //  destiPickerView.selectRow(1, inComponent: 0, animated: true)
        setupBehavior()
        back.backgroundColor = UIColor(patternImage: UIImage(named:"BB")!)
    }
    // design
    private func addShaddowToQuoteLabel(){
        goLanguage.layer.shadowOpacity = 2.9
        goLanguage.layer.shadowOffset = CGSize(width: 3, height: 3)
        //label translate
        languageTranslate.layer.shadowColor = UIColor.black.cgColor
        languageTranslate.layer.shadowOpacity = 2.9
        languageTranslate.layer.shadowOffset = CGSize(width: 2, height: 2)
        
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        translation()
    }
    // Function to shown the loading interface
    private func toggleActivityIndicator(shown: Bool) {
        buttonTranslate.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    //  Function for fetching the translation from the model
    private  func translation(){
       // index = destiPickerView.selectedRow(inComponent: 0)
        guard goTextTranslate.text  != "" else { showAlert(title: "Error", message: "no text is entered !")
            return
        }
        guard let textTextField = goTextTranslate.text else {return}
        toggleActivityIndicator(shown: true)
        TranslateService.shared.getTranslate( text: textTextField) { (success, translation) in
            
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false)
                if success, let translation = translation?.data.translations {
                    
                    let textTranslated = translation[0].translatedText
                    self.resultTranslate.text = textTranslated
                } else {
                    self.showAlert( title:"Error data", message: "Translation's data download failed!")
                }
            }
        }
    }
    // Function to dismiss the keyboard
    @IBAction func dismisskeyboard(_ sender: UITapGestureRecognizer) {
        goTextTranslate.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goTextTranslate.resignFirstResponder()
        return true
    }
    
    //Method to handle setup behavior of textToTranslateTextField
    private func setupBehavior() {
        goTextTranslate.addTarget(self, action: #selector(textToTranslateTextFieldDidChange), for: .editingChanged)
    }
    
    //Method to handle isEnabled property of translationButton when textToTranslateTextField is empty
    @objc func textToTranslateTextFieldDidChange() {
        guard let text = goTextTranslate.text, !text.isEmpty else {
            buttonTranslate.isEnabled = false
            return
        }
        buttonTranslate.isEnabled = true
    }
    
}

extension  TranslateController: UIPickerViewDelegate, UIPickerViewDataSource {
    
     // Number of component of the pickers: 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   // Number of elements: count on language
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TranslateService.shared.language.count
        
    }
   // Text: the description of each language
    func pickerView(_ PickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return TranslateService.shared.language[row].descr
    }
    
    // When the user select a row, we send this row to the model.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let destinationLangage =
            TranslateService.shared.language[destiPickerView.selectedRow(inComponent: 0)].code
        
        if pickerView == destiPickerView{
           TranslateService.shared.setDestinationLanguage(toLanguage: destinationLangage)
        }
        
    }
    
}
