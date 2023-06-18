//
//  SignupTermDetailModal.swift
//  ios-tripbook
//
//  Created by DDang on 6/18/23.
//

import SwiftUI
import TBUtil

protocol SignupTermDetailModalDelegate {
    func didTapHideModalButton()
}

struct SignupTermDetailModal: View {
    var delegate: SignupTermDetailModalDelegate?
    
    var term: SignupTermsViewModel.TermType
    
    init(_ term: SignupTermsViewModel.TermType, delegate: SignupTermDetailModalDelegate? = nil) {
        self.delegate = delegate
        self.term = term
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TBColor.grayscale.levels[10].opacity(0.6).ignoresSafeArea()
            
            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(TBColor.grayscale.levels[1])
                    .frame(maxWidth: .infinity)
                    .frame(height: 398)
                    .overlay(
                        VStack(spacing: 12) {
                            Text(self.term.getTitle())
                                .font(TBFont.title_3)
                                .foregroundColor(TBColor.grayscale.levels[9])
                                .padding(.top, 24)
                            ScrollView {
                                Text(self.term.getDescription())
                                .font(TBFont.caption_1)
                                .foregroundColor(TBColor.grayscale.levels[7])
                                .lineSpacing(18 / 12)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 24)
                            }
                        }
                )
                
                Button(action: {
                    self.delegate?.didTapHideModalButton()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 19)
                            .foregroundColor(TBColor.grayscale.levels[9])
                        
                        HStack(spacing: 6.78) {
                            TBIcon.cancel.iconSize(size: .tiny)
                                .foregroundColor(TBColor.grayscale.levels[1])
                            Text("닫기")
                                .font(TBFont.title_4)
                                .foregroundColor(TBColor.grayscale.levels[1])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 38)
            }.padding(.horizontal, 20)
        }
    }
}

struct SignupTermDetailModal_Preview: PreviewProvider {
    static var previews: some View {
        SignupTermDetailModal(.Service)
    }
}
