//
//  TravelNewsDetailView.swift
//  ios-tripbook
//
//  Created by RED on 2023/11/27.
//

import Foundation
import SwiftUI
import Combine

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct TravelNewsDetailView: View {
    @ObservedObject var viewModel: TravelNewsDetailViewModel
    @State private var webViewHeight: CGFloat = .zero
    @State private var isAppear = false
    @State private var isPopupReportView: Bool = false
    @State private var isShowedMoreSheet = false
    @Environment(\.dismiss) private var dismiss
    
    init(item: TravelNewsModel) {
        self.viewModel = TravelNewsDetailViewModel(item: item)
    }
    
    var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var deviceHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    coverView()
                    authorView()
                    htmlView(content: viewModel.travelNews.content)
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
                                        isPopupReportView = true
                                    }, label: {
                                        TBIcon.report.iconSize(size: .medium)
                                    })
                                    .foregroundStyle(.white)
                                    if viewModel.isOwner {
                                        Button(action: {
                                            isShowedMoreSheet = true
                                        }, label: {
                                            TBIcon.more.active.iconSize(size: .medium)
                                        })
                                        .foregroundStyle(.white)
                                        .confirmationDialog("", isPresented: $isShowedMoreSheet) {
                                            Button("수정") {
                                                
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
                                            Button("취소", role: .cancel) {}
                                        }
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
            .onPreferenceChange(ScrollOffsetKey.self, perform: { value in
                viewModel.setOffset(value)
            })
            .ignoresSafeArea()
            .toolbarBackground(.hidden, for: .navigationBar)
            .onAppear {
                guard !isAppear else { return }
                isAppear = true
                UIScrollView.appearance().bounces = false
            }
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
        .overlay(content: {
            Color.black
                .ignoresSafeArea()
                .opacity(isPopupReportView ? 0.6 : 0)
            ReportPopupView(postId: viewModel.travelNews.id, isPresented: $isPopupReportView)
                .opacity(isPopupReportView ? 1 : 0)
        })
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
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
    
    func profileView(url: URL) -> some View {
            AsyncImage(url: url)
            .frame(width: 14, height: 14)
            .clipShape(Circle())
            .overlay {
                RoundedRectangle(cornerRadius: 9)
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(width: 18, height: 18)
            }
    }
    
    func authorView() -> some View {
        HStack(alignment: .center) {
            Spacer()
            
            if let url = viewModel.travelNews.author.profileUrl {
                profileView(url: url)
            }
            
            Text(viewModel.travelNews.author.name)
                .font(.suit(.bold, size: 12))
                .padding(.trailing, 20)
        }
        .frame(width: deviceWidth, height: 48)
        .background {
            Rectangle()
                .fill(TBColor.grayscale._1)
        }
    }
    
    func coverView() -> some View {
        ZStack(alignment: .topLeading) {
            if let url = viewModel.travelNews.thumbnailURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: deviceWidth, height: deviceHeight)
                                .clipped()
                        default:
                            Text("Failed to load the image")
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    if let url = viewModel.travelNews.author.profileUrl {
                        profileView(url: url)
                    }
                    
                    Text(viewModel.travelNews.author.name)
                        .foregroundColor(.white)
                        .font(.suit(.bold, size: 12))
                }
                
                Text(viewModel.travelNews.title)
                    .font(.suit(.bold, size: 24))
                    .foregroundColor(.white)
            }
            .offset(.init(width: 20, height: 210))
        }
        .frame(width: deviceWidth, height: deviceHeight)
    }
    
    func htmlView(content: String) -> some View {
        HTMLView(htmlString: content, contentHeight: $webViewHeight)
            .frame(height: webViewHeight)
    }
    
    func bottomView() -> some View {
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
                    .font(.suit(.medium, size: 10))
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
