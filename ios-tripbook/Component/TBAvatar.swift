//
//  TBAvatar.swift
//  ios-tripbook
//
//  Created by DDang on 7/10/23.
//

import Foundation
import SwiftUI

import Kingfisher

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
    let profileImageURL: URL?
    private let size: CGFloat
    
    init(type: ViewType, size: CGFloat = 18, profileImageURL: URL? = nil) {
        self.type = type
        self.size = size
        self.profileImageURL = profileImageURL
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: size, height: size)
                .foregroundColor(TBColor.grayscale._5)
            
            KFImage(profileImageURL)
                .placeholder({
                    Image("AvatarDefault")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 8)
                })
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
            
            Circle()
                .inset(by: 0.5)
                .stroke(type.getGradient(), lineWidth: 1)
                .frame(width: size, height: size)
                .shadow(TBShadow._1)
        }
    }
}

struct TBAvatar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                TBAvatar(type: .basic)
                TBAvatar(type: .basic, profileImageURL: .init(string: "https://tripbook-bucket.s3.ap-northeast-2.amazonaws.com/member/profile/51fa4c27-0a0a-4c69-ba79-7ff1b8eaef358964%20bytes.jpeg"))
            }
            
            HStack {
                TBAvatar(type: .editor)
                TBAvatar(type: .editor, profileImageURL: .init(string: "https://tripbook-bucket.s3.ap-northeast-2.amazonaws.com/member/profile/51fa4c27-0a0a-4c69-ba79-7ff1b8eaef358964%20bytes.jpeg"))
            }
            
            HStack {
                TBAvatar(type: .bestEditor)
                TBAvatar(type: .bestEditor, profileImageURL: .init(string: "https://tripbook-bucket.s3.ap-northeast-2.amazonaws.com/member/profile/51fa4c27-0a0a-4c69-ba79-7ff1b8eaef358964%20bytes.jpeg"))
            }
        }
    }
}
