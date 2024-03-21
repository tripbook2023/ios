//
//  SignupTermDetailModal.swift
//  ios-tripbook
//
//  Created by DDang on 6/18/23.
//

import SwiftUI

protocol SignupTermDetailModalDelegate {
    func didTapHideModalButton()
}

struct SignupTermDetailModal: View {
    var delegate: SignupTermDetailModalDelegate?
    
    @Binding var term: SignupTermsViewModel.TermType?
    
    var deviceHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    init(_ term: Binding<SignupTermsViewModel.TermType?>, delegate: SignupTermDetailModalDelegate? = nil) {
        self.delegate = delegate
        self._term = term
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.6).ignoresSafeArea()
            
            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(TBColor.grayscale._5)
                    .frame(maxWidth: .infinity)
                    .frame(height: deviceHeight * 0.6)
                    .overlay(
                        VStack(spacing: 12) {
                            Text(self.term?.getTitle() ?? "")
                                .font(TBFont.title_3)
                                .foregroundColor(TBColor.grayscale._80)
                                .padding(.top, 24)
                            GeometryReader { g in
                                ScrollView {
                                    if let url = term?.getDescription() {
                                        TermDetailView(url: url)
                                            .frame(height: g.size.height - 8)
                                    }
                                    
                                }
                            }
                        }
                    )
                Button(action: {
                    term = nil
                    self.delegate?.didTapHideModalButton()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 19)
                            .foregroundColor(TBColor.grayscale._80)
                        
                        HStack(spacing: 4) {
                            TBIcon.cancel.iconSize(size: .tiny)
                                .foregroundColor(TBColor.grayscale._5)
                            Text("닫기")
                                .font(TBFont.title_4)
                                .foregroundColor(TBColor.grayscale._5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 38)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
    }
}

struct SignupTermDetailModal_Preview: PreviewProvider {
    static var previews: some View {
        SignupTermDetailModal(.constant(.Service))
    }
}
