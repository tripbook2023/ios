//
//  OnboardingView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/23.
//

import SwiftUI
import Lottie

struct OnboardingView: View {
    @ObservedObject var viewModel = OnboardingViewModel()
    var body: some View {
        ZStack {
            if viewModel.presentView == .root {
                RootView()
            } else {
                SignupSocialView()
            }
            
            Color.white
                .ignoresSafeArea(edges: .all)
                .overlay {
                    LottieView(
                        animation: LottieAnimation.named("tripbook")
                    )
                    .playing()
                    .animationDidFinish { _ in
                        if viewModel.presentView != nil {
                            withAnimation(Animation.spring().speed(1)) {
                                viewModel.isHeddin.toggle()
                            }
                        }
                    }
                }
                .opacity(viewModel.isHeddin ? 0 : 1)
        }
        
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
