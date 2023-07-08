//
//  File.swift
//  
//
//  Created by DDang on 2023/05/25.
//

import Foundation
import SwiftUI

extension Image {
    /// TBIcon의 사이즈를 지정하는 Function.
    func iconSize(size: TBIconSize) -> some View {
        return self
            .resizable()
            .scaledToFit()
            .frame(width: size.rawValue, height: size.rawValue)
    }
}

/// TBIcon의 정형화된 사이즈를 정의
/// - Author: 김민규
/// - Date: 2023/05/25
enum TBIconSize: CGFloat {
    case tiny = 14
    case small = 18
    case medium = 24
    case big = 36
}

/// Tripbook 고유 Icon 명세
/// - Author: 김민규
/// - Date: 2023/05/25
struct TBIcon {
    struct TBIconState {
        public let normal: Image
        public let active: Image
        
        init(_ iconName: String) {
            self.normal = Image(iconName + "/Default")
            self.active = Image(iconName + "/Active")
        }
    }
    
    struct TBNavigationIcons {
        let home = TBIconState("Navigation/Home")
        let mypage = TBIconState("Navigation/Mypage")
        let plus = TBIconState("Navigation/Plus")
        let tripbook = TBIconState("Navigation/Tripbook")
    }
    
    struct TBStateIcons {
        let error = Image("State/Error")
    }
    
    static let before = Image("Before")
    static let bell = Image("Bell")
    static let bookmark = Image("Bookmark")
    static let camera = Image("Camera")
    static let cancel = Image("Cancel")
    static let check = Image("Check")
    static let comment = Image("Comment")
    static let delete = Image("Delete")
    static let down: [Image] = [
        Image("Down/01"),
        Image("Down/02")
    ]
    static let edit = Image("Edit")
    static let filter = Image("Filter")
    static let keyboard = Image("Keyboard")
    static let like = Image("Like")
    static let location: [Image] = [
        Image("Location/01"),
        Image("Location/02")
    ]
    static let more = TBIconState("More")
    static let navigation = TBNavigationIcons()
    static let next: Image = Image("Next")
    static let picture: Image = Image("Picture")
    static let search = Image("Search")
    static let share = Image("Share")
    static let timer: Image = Image("Timer")
    static let txt = Image("Txt")
    static let up = Image("Up")
    static let writing = Image("Writing")
    
    static let state = TBStateIcons()
}