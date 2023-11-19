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
    @StateObject var viewModel = OnboardingViewModel()
    @State private var anyCancellable = Set<AnyCancellable>()
    var body: some View {
        ZStack {
            if viewModel.isPresentRoot {
                RootView(isPresented: $viewModel.isPresentRoot)
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
        viewModel.$isPresentRoot
            .receive(on: DispatchQueue.main)
            .combineLatest(viewModel.$isAnimationFinish)
            .filter { $1 && !self.viewModel.isHidden }
            .sink { _ in
                withAnimation(Animation.spring().speed(1)) {
                    viewModel.isHidden = true
                }
            }.store(in: &anyCancellable)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
