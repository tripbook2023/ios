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
                        viewModel.isAnimationFinish = true
                    }
                    .frame(width: 250, height: 73)
                }
                .opacity(viewModel.isHidden ? 0 : 1)
        }.onAppear {
            bind()
        }
    }
}

extension OnboardingView {
    private func bind() {
        viewModel.$presentView
            .combineLatest(viewModel.$isAnimationFinish)
            .filter { $0 != nil && $1 }
            .sink { _ in
                withAnimation(Animation.spring().speed(1)) {
                    viewModel.isHidden.toggle()
                }
            }.store(in: &anyCancellable)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
