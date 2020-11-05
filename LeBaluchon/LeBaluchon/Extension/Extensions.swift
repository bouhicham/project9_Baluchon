//
//  Extensions.swift
//  Testing
//
//  Created by hicham on 26/05/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation

extension String{
       func capitalizingFirstLetter() -> String {
           return prefix(1).uppercased() + self.lowercased().dropFirst()
   }
}
        //convert the received parameter to a string
       func convertToString(value: Double) -> String {
            return String(value)
        }

