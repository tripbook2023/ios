//
//  OnboardingView.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/23.
//

import SwiftUI
import Lottie
import Combine

struct OnboardingView: View {
    @ObservedObject var viewModel = OnboardingViewModel()
    @State private var anyCancellable = Set<AnyCancellable>()
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
                        animation: LottieAnimation.named("tripbookOnboardingLottie")
                    )
                    .playing()
                    .animationDidFinish { _ in
                        viewModel.$presentView.sink { value in
                            if value != nil {
                                withAnimation(Animation.spring().speed(1)) {
                                    viewModel.isHeddin.toggle()
                                }
                            }
                        }.store(in: &anyCancellable)
                    }
                    .frame(width: 250, height: 73)
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
