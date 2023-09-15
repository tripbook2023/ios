//
//  TBAvatar.swift
//  ios-tripbook
//
//  Created by DDang on 7/10/23.
//

import Foundation
import SwiftUI

struct TBAvatar: View {
    enum ViewType {
        case basic
        case editor
        case bestEditor
        
        func getGradient() -> LinearGradient {
            switch self {
            case .basic:
                return LinearGradient(
                    colors: [
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            case .editor:
                return LinearGradient(
                    colors: [
                        .init(rgb: .init(red: 144, green: 255, blue: 170)),
                        .init(rgb: .init(red: 103, green: 203, blue: 148))
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            case .bestEditor:
                return LinearGradient(
                    colors: [
                        .init(rgb: .init(red: 255, green: 193, blue: 100)),
                        .init(rgb: .init(red: 255, green: 126, blue: 61)),
                        .init(rgb: .init(red: 255, green: 118, blue: 50))
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
    }
    
    let type: ViewType
    let profileImage: UIImage?
    
    init(type: ViewType, profileImage: UIImage? = nil) {
        self.type = type
        self.profileImage = profileImage
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 18, height: 18)
                .foregroundColor(TBColor.grayscale._5)
            
            Image("AvatarDefault")
                .resizable()
                .scaledToFit()
                .frame(width: 8)
            
            Image(uiImage: self.profileImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 18, height: 18)
                .clipShape(Circle())
            
            Circle()
                .inset(by: 0.5)
                .stroke(type.getGradient(), lineWidth: 1)
                .frame(width: 18, height: 18)
                .shadow(TBShadow._1)
        }
    }
}

struct TBAvatar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                TBAvatar(type: .basic)
                TBAvatar(type: .basic, profileImage: .init(named: "SampleProfileImage"))
            }
            
            HStack {
                TBAvatar(type: .editor)
                TBAvatar(type: .editor, profileImage: .init(named: "SampleProfileImage"))
            }
            
            HStack {
                TBAvatar(type: .bestEditor)
                TBAvatar(type: .bestEditor, profileImage: .init(named: "SampleProfileImage"))
            }
        }
    }
}
