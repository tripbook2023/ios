//
//  TBTag.swift
//  ios-tripbook
//
//  Created by DDang on 7/11/23.
//

import SwiftUI

struct TBTag: View {
    enum ViewType: String {
        case awaitingApproval = "승인대기중"
        case approved = "승인완료"
        case rejected = "반려"
    }
    
    let type: ViewType
    let completion: (() -> Void)?
    
    init(_ type: ViewType, completion: (() -> Void)? = nil) {
        self.type = type
        self.completion = completion
    }
    
    var body: some View {
        Button(action: {
            self.completion?()
        }) {
            HStack(spacing: 0) {
                Text(self.type.rawValue)
                    .font(TBFont.caption_2)
                    .foregroundColor(
                        self.type == .awaitingApproval ? TBColor.point.green[2] :
                            self.type == .approved ? .white :
                            self.type == .rejected ? TBColor.state.warning : .clear
                    )
                
                if self.type == .rejected {
                    TBIcon.next.iconSize(size: .tiny)
                        .foregroundColor(TBColor.state.warning)
                }
            }
            .padding(.vertical, 2)
            .padding(.leading, 4)
            .padding(.trailing, self.type != .rejected ? 4 : 0)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(
                        self.type == .awaitingApproval ? TBColor.point.green[0] :
                            self.type == .approved ? TBColor.primary._50 :
                            self.type == .rejected ? TBColor.grayscale._10 : .clear
                    )
            )
        }.shadow(TBShadow._1)
    }
}

struct TBTag_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            TBTag(.awaitingApproval)
            TBTag(.approved)
            TBTag(.rejected)
        }
    }
}
