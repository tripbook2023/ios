//
//  TravelNewsDetailView.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/27.
//

import Foundation
import SwiftUI
import Combine
import Kingfisher

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

private struct WillDisappearHandler: UIViewControllerRepresentable {

    let onWillDisappear: () -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        ViewWillDisappearViewController(onWillDisappear: onWillDisappear)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    private class ViewWillDisappearViewController: UIViewController {
        let onWillDisappear: () -> Void

        init(onWillDisappear: @escaping () -> Void) {
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
    }
}

extension View {
    func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        background(WillDisappearHandler(onWillDisappear: perform))
    }
}

struct TravelNewsDetailView: View {
    @ObservedObject var viewModel: TravelNewsDetailViewModel
    @State private var webViewHeight: CGFloat = .zero
    @State private var isAppear = false
    @State private var isShowedMoreSheet = false
    @State private var isPresentedEditView = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.popupView) private var popupView
    
    init(item: TravelNewsModel) {
        self.viewModel = TravelNewsDetailViewModel(item: item)
    }
    
    var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var deviceHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    private var thumbnailProcessor: ResizingImageProcessor {
        return ResizingImageProcessor(
            referenceSize: .init(width: deviceWidth, height: deviceHeight),
            mode: .aspectFill
        )
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    coverView()
                    authorView()
                    HStack(spacing: 4) {
                        if viewModel.travelNews.location != nil {
                            TBIcon.location[1].iconSize(size: .small)
                            Text("\(viewModel.travelNews.location!.placeName)")
                                .font(TBFont.caption_1)
                                .foregroundStyle(TBColor.grayscale._40)
                        }
                        Spacer()
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
                    htmlView(content: viewModel.travelNews.content)
                        .padding(.horizontal, 12)
                    scrollObservableView
                }
                .padding(.bottom, 56)
                .overlay {
                    VStack {
                        TBAppBar(
                            title: nil,
                            onClickedBackButton: {
                                dismiss()
                            },
                            rightItem: {
                                HStack(spacing: 12) {
                                    Button(action: {
                                        popupView.wrappedValue = .report(
                                            postId: viewModel.travelNews.id,
                                            onReport: {
                                                dismiss()
                                            }
                                        )
                                    }, label: {
                                        TBIcon.report.iconSize(size: .medium)
                                    })
                                    .foregroundStyle(.white)
                                    
                                    Button(action: {
                                        isShowedMoreSheet = true
                                    }, label: {
                                        TBIcon.more.active.iconSize(size: .medium)
                                    })
                                    .foregroundStyle(.white)
                                    .confirmationDialog("", isPresented: $isShowedMoreSheet) {
                                        if viewModel.isOwner {
                                            Button("수정") {
                                                isPresentedEditView = true
                                            }
                                            Button("제거", role: .destructive) {
                                                Task {
                                                    await viewModel.deletePost()
                                                    await MainActor.run {
                                                        NotificationCenter.default.post(name: .refreshMain, object: nil)
                                                        dismiss()
                                                    }
                                                }
                                            }
                                        } else {
                                            Button("사용자 차단", role: .destructive) {
                                                popupView.wrappedValue = .userBlock(
                                                    user: viewModel.travelNews.author,
                                                    onBlock: {
                                                        dismiss()
                                                    }
                                                )
                                            }
                                        }
                                        
                                        Button("취소", role: .cancel) {}
                                    }
                                    
                                }
                            },
                            iconColor: .white
                        )
                        .padding(.top, 40)
                        .padding(.horizontal, 20)
                        Spacer()
                    }
                }
                
            }
            .onAppear {
                if !isAppear {
                    UIScrollView.appearance().bounces = false
                    isAppear = true
                }
            }
            .onWillDisappear {
                UIScrollView.appearance().bounces = true
            }
            .onPreferenceChange(ScrollOffsetKey.self, perform: { value in
                viewModel.setOffset(value)
            })
            .ignoresSafeArea()
            .toolbarBackground(.hidden, for: .navigationBar)
            .overlay {
                VStack {
                    Spacer()
                    if viewModel.isDownScroll {
                        bottomView()
                            .transition(.move(edge: .bottom))
                            .animation(.linear.speed(3.0))
                    }
                }
                .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(isPresented: $isPresentedEditView) {
            RegisterTravelNewsView(editItem: viewModel.travelNews)
        }
    }
    
    private var scrollObservableView: some View {
        GeometryReader { proxy in
            let offsetY = proxy.frame(in: .global).origin.y
            Color.clear
                .preference(
                    key: ScrollOffsetKey.self,
                    value: offsetY
                )
        }
        .frame(height: 0)
    }
    
    private func profileView(url: URL?) -> some View {
        TBAvatar(
            type: .basic,
            size: 18,
            profileImageURL: url
        )
    }
    
    private func authorView() -> some View {
        HStack(alignment: .center) {
            Spacer()
            profileView(url: viewModel.travelNews.author.profileUrl)
            Text(viewModel.travelNews.author.name)
                .font(TBFont.title_4)
                .padding(.trailing, 20)
        }
        .frame(width: deviceWidth, height: 48)
        .background {
            Rectangle()
                .fill(TBColor.grayscale._1)
        }
    }
    
    private func coverView() -> some View {
        ZStack(alignment: .topLeading) {
            KFImage.url(viewModel.travelNews.thumbnailURL)
                .placeholder({
                    TBColor.grayscale._30
                })
                .setProcessor(self.thumbnailProcessor)
                .cacheMemoryOnly()
                .frame(width: deviceWidth, height: deviceHeight)
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    profileView(url: viewModel.travelNews.author.profileUrl)
                    Text(viewModel.travelNews.author.name)
                        .foregroundColor(.white)
                        .font(TBFont.title_4)
                }
                
                Text(viewModel.travelNews.title)
                    .font(TBFont.heading_1)
                    .foregroundColor(.white)
                    .padding(.trailing, 20)
            }
            .offset(.init(width: 20, height: 210))
        }
        .frame(width: deviceWidth, height: deviceHeight)
    }
    
    private func htmlView(content: String) -> some View {
        HTMLView(htmlString: content, contentHeight: $webViewHeight)
            .frame(height: webViewHeight)
    }
    
    private func bottomView() -> some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(TBColor.grayscale._10)
                .frame(width: deviceWidth, height: 1)
                
            HStack(spacing: 1) {
                Button {
                    viewModel.likeButtonDidTap()
                } label: {
                    if viewModel.travelNews.isLiked {
                        TBIcon.like.active.iconSize(size: .medium)
                            .foregroundColor(TBColor.primary._50)
                    } else {
                        TBIcon.like.normal.iconSize(size: .medium)
                            .foregroundStyle(TBColor.grayscale._50)
                    }
                    
                }
                .frame(width: 24, height: 24)
                
                Text("\(viewModel.travelNews.likeCount)")
                    .font(TBFont.caption_2)
                    .foregroundColor(TBColor.grayscale._50)
                
                Spacer()
            }
            .frame(height: 56)
            .padding(.horizontal, 20)
        }
        .background(.white)
    }
}
#if DEBUG
#Preview {
    TravelNewsDetailView(item: TravelNewsModel.dummy)
}
#endif
