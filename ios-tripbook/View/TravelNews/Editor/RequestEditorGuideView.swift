//
//  RequestEditorGuideView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/08/01.
//

import SwiftUI

struct RequestEditorGuideView: View {
    let procedures = ["신청", "심사", "합격"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("에디터 신청 방법")
                .font(TBFont.heading_2)
                .foregroundColor(TBColor.grayscale.levels[9])
            
            ZStack {
                HStack(spacing: 10) {
                    ForEach(Array(procedures.enumerated()), id: \.offset) { index, procedure in
                        makeRoundedBordeRectangle {
                            VStack {
                                Text("STEP \(index + 1)")
                                    .foregroundColor(TBColor.primary.levels[5])
                                    .font(TBFont.body_4)
                                Spacer().frame(height: 16)
                                Text(procedure)
                                    .foregroundColor(.white)
                                    .font(TBFont.body_4)
                                    .padding(.bottom)
                            }
                        }
                    }
                }
                
                HStack {
                    Circle().frame(width: 28, height: 28)
                        .foregroundColor(TBColor.primary.levels[4])
                        .overlay {
                            TBIcon.next.iconSize(size: .tiny)
                                .foregroundColor(.white)
                        }
                    
                    Spacer().frame(width: 87)
                    
                    Circle().frame(width: 28, height: 28)
                        .foregroundColor(TBColor.primary.levels[4])
                        .overlay {
                            TBIcon.next.iconSize(size: .tiny)
                                .foregroundColor(.white)
                        }
                }.padding(.top, 20)
            }
        }
    }
    
    @ViewBuilder
    private func makeRoundedBordeRectangle<V>(content: () -> V) -> some View where V : View {
        ZStack(alignment: .center) {
            RoundedRectangle(
                cornerRadius: 13
            ).frame(width: 105, height: 88)
            .foregroundColor(TBColor.grayscale.levels[3])
            
            RoundedRectangle(
                cornerRadius: 12
            ).frame(width: 103, height: 86)
            .foregroundColor(TBColor.grayscale.levels[9])
            .overlay {
                content()
            }
        }
    }
}

struct RequestEditorGuideView_Previews: PreviewProvider {
    static var previews: some View {
        RequestEditorGuideView()
    }
}
