//
//  RegisterationModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/06/17.
//

import Foundation
import SwiftUI

struct RegisterationUser {
    var email: String = ""
    var name: String = ""
    var profileImage: UIImage? = nil
    var terms: [String:Bool] = [
        Term.Service.rawValue       : false,
        Term.PersonalInfo.rawValue  : false,
        Term.Location.rawValue      : false,
        Term.Marketing.rawValue     : false
    ]
    var gender: Gender? = nil
    var birth: String = ""
}
