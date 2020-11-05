//
//  Translate.swift
//  Testing
//
//  Created by hicham on 28/05/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation
//Struct for matching Json response
struct Translate: Decodable {
    var data: TranslationData
}

struct TranslationData : Decodable {
    var translations: [TranslationText]
}
struct TranslationText : Decodable {
    var translatedText: String
 
}
