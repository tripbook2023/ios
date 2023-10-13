//
//  TravelNewsWritingView.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import SwiftUI
import RichTextKit

struct TravelNewsPostView: View {
    @ObservedObject var viewModel = TravelNewsPostViewModel(title: "", textContent: .init(string: ""))
    
    var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    @State var actionBarOffset: CGFloat = UIScreen.main.bounds.width/2
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case title
        case content
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 0) {
                        TravelNewsPostHeaderView(isEnabledPostButton: .constant(false))
                        
                        ZStack(alignment: .bottom) {
                            Image("")
                                .resizable()
                                .frame(height: 400)
                                .aspectRatio(0.9375, contentMode: .fill)
                                .background(TBColor.grayscale._90.opacity(0.3))
                            
                            Button(action: {
                                
                            }) {
                                VStack(spacing: 8) {
                                    TBIcon.picture.iconSize(size: .big)
                                        .foregroundColor(TBColor.grayscale._1)
                                    
                                    Text("사진을 등록해주세요")
                                        .font(.suit(.regular, size: 10))
                                        .foregroundColor(TBColor.grayscale._5)
                                }
                            }.padding(.bottom, 161)
                            
                            VStack(spacing: 16) {
                                TextField("제목을 입력해주세요", text: $viewModel.title)
                                    .lineLimit(2)
                                    .font(TBFont.heading_1)
                                    .foregroundColor(.white)
                                    .focused($focusedField, equals: .title)
                                    .shadow(TBShadow._1)
                                    .onSubmit {
                                        focusedField = .content
                                    }
                                
                                HStack(spacing: 1) {
                                    Spacer()
                                    
                                    (Text("\(viewModel.title.count)").foregroundColor(TBColor.primary._20) +
                                     Text("/30").foregroundColor(TBColor.grayscale._5))
                                    .font(.suit(.medium, size: 10))
                                }
                                .padding(.vertical, 10)
                            }
                            .frame(width: (deviceWidth-20))
                            .id(Field.title)
                            .onChange(of: viewModel.title) { newTitle in
                                if newTitle.count > 30 {
                                    let editiedTitle = String(newTitle.prefix(30))
                                    viewModel.title = editiedTitle
                                }
                            }
                        }
                        
                        VStack(spacing: 0) {
                            Button("html") {
                                viewModel.extract()
                            }
                            // add location
                            
                            // TextEditor
                            ZStack(alignment: .topLeading) {
                                
                                RichTextEditor(text: $viewModel.textContent, context: viewModel.context)
                                    .frame(width: (deviceWidth-20), height: 200)
                                    .focused($focusedField, equals: .content)
                                
                                if viewModel.textContent.length == 0 {
                                    Text("최소 800자 이상의 글자수를 작성해주세요")
                                        .font(TBFont.body_4)
                                        .foregroundColor(TBColor.grayscale._20)
                                        .padding(.top, 4)
                                        .padding(.leading, 4)
                                }
                                
                            }
                            .padding(.top, 32)
                            .id(Field.content)
                            
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .onChange(of: focusedField) { newFocusedField in
                    withAnimation {
                        proxy.scrollTo(newFocusedField, anchor: .center)
                    }
                }
            }

            
            decorationView
                .ignoresSafeArea(edges: .top)
        }
    }
    
    var decorationView: some View {
        VStack(alignment: .center, spacing: 0) {
            
            HStack(spacing: 1) {
                Spacer()
                
                Text("\(viewModel.textContent.length)")
                    .foregroundColor(TBColor.primary._70)
 
                Text("/10,000")
                    .foregroundColor(TBColor.grayscale._20)
            }
            .font(.suit(.medium, size: 10))
            .frame(width: (deviceWidth-20), height: 32)
            
            Divider()
                .frame(minHeight: 1)
                .overlay(TBColor.grayscale._5)
            
            HStack {
                actionView
                    .frame(width: deviceWidth)
                
                textDecorationView
                    .frame(width: deviceWidth)
            }
            .offset(x: actionBarOffset)
            
        }
    }
    
    var actionView: some View {
        HStack(spacing: 0) {
            Button(action: {
                
            }) {
                TBIcon.keyboard.iconSize(size: .medium)
                    .foregroundColor(TBColor.grayscale._40)
            }
            
            Rectangle()
                .frame(width: 1, height: 24)
                .padding(.horizontal, 14)
                .foregroundColor(TBColor.grayscale._10)
            
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        actionBarOffset = -(deviceWidth / 2)
                    }
                }) {
                    TBIcon.txt.iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._40)
                }
                
                Button(action: {
                    
                }) {
                    TBIcon.picture.iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._40)
                }
                
                Button(action: {
                    
                }) {
                    TBIcon.location[0].iconSize(size: .medium)
                        .foregroundColor(TBColor.grayscale._40)
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Text("임시 1")
                    .font(TBFont.body_4)
                    .foregroundColor(TBColor.grayscale._30)
                
                Button(action: {
                    
                }) {
                    Text("임시저장")
                        .font(TBFont.body_4)
                        .foregroundColor(TBColor.grayscale._30)
                }
            }
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
    }
    
    var textDecorationView: some View {
        HStack(spacing: 24) {
            Button {
                withAnimation {
                    actionBarOffset = (deviceWidth / 2)
                }
            } label: {
                TBIcon.before[1]
                    .imageScale(.medium)
            }
            
            Button {
                viewModel.context.fontSize = 20
            } label: {
                Text("제목")
                    .font(TBFont.body_4)
                    .foregroundColor(TBColor.grayscale._50)
            }
            
            Button {
                viewModel.context.fontSize = 16
            } label: {
                Text("소제목")
                    .font(TBFont.body_4)
                    .foregroundColor(TBColor.grayscale._50)
            }
            
            Button {
                viewModel.context.fontSize = 14
            } label: {
                Text("본문")
                    .font(TBFont.body_4)
                    .foregroundColor(TBColor.grayscale._50)
            }
            
            Button {
                viewModel.context.isBold.toggle()
            } label: {
                Text("B")
                    .font(TBFont.body_4)
                    .foregroundColor(TBColor.grayscale._50)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
                                                
    }
}

struct TravelNewsPostHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var isEnabledPostButton: Bool
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    TBIcon.before[0].iconSize(size: .medium)
                        .foregroundColor(.black)
                }.shadow(TBShadow._1)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                Text("여행소식 작성")
                    .font(TBFont.body_3)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .shadow(TBShadow._1)
            
            HStack {
                Spacer()
                
                TBButton(type: .filled, size: .small, title: "등록", isEnabled: self.$isEnabledPostButton)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct TravelNewsPostView_Previews: PreviewProvider {
    static var previews: some View {
        TravelNewsPostView()
    }
}
