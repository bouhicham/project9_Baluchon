//
//  TranslateService.swift
//  Testing
//
//  Created by hicham on 29/05/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation

class TranslateService{
    
    // Singleton pattern
    static var shared = TranslateService()
    private init() {}
    
    private var index: Int = 0
    var languageList = [String]()
    let language: [(code: String, descr: String)] =
        
        [("de", "Allemand"),
         ("en", "Anglais"),
         ("ar", "Arabe"),
         ("es", "Espagnol"),
         ("iw", "Hébreu"),
         ("hi", "Hindi"),
         ("it", "Italien"),
         ("la", "Latin"),
         ("tr", "Turc"),
        ]
    // The origin language for translation
    var originLanguage = "fr"
    
    // The destination language for translation
    var destinationLanguage = "en"
    
    var task: URLSessionDataTask?
    var translateSession: URLSession =  URLSession(configuration: .default)
    init(translateSession: URLSession )
    {
        self.translateSession = translateSession
    }
    private func urlTranslate(text: String) -> String {
        var translateURL: String
        guard let translateURLconverted = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return ""}
        translateURL = TranslateApi.baseUrl + translateURLconverted + TranslateApi.key + TranslateApi.body + TranslateApi.format
        let url = translateURL
        return url
        
    }
    
    //Method to create an URLrequest POST
    func createTranslationRequest(text: String ) -> URLRequest? {
        let url = URL(string: urlTranslate(text: text))!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "&source=\(originLanguage)&target=\(destinationLanguage)&format=text"
        
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    //Get the destination language
    func getDestinationLanguage() -> String {
        return destinationLanguage
    }
    
    // Set destination language
    func setDestinationLanguage(toLanguage: String) {
        self.destinationLanguage = toLanguage
    }
    
    func getTranslate( text: String, callback: @escaping (Bool, Translate?) -> Void) {
        let request = createTranslationRequest(text: text)
        task?.cancel()
        task = translateSession.dataTask(with: request!) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let weatherResponseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                
                callback(true, weatherResponseJSON)
                print(weatherResponseJSON)
            }
        }
        self.task?.resume()
    }
}



