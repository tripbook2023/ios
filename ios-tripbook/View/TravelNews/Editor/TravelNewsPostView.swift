//
//  TravelNewsWritingView.swift
//  ios-tripbook
//
//  Created by DDang on 7/16/23.
//

import SwiftUI

struct TravelNewsPostView: View {
    var body: some View {
        
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
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
                            TextField("제목을 입력해주세요", text: .constant(""))
                                .lineLimit(2)
                                .font(TBFont.heading_1)
                                .foregroundColor(.white)
                                .shadow(TBShadow._1)
                            
                            HStack(spacing: 1) {
                                Spacer()
                                
                                (Text("0").foregroundColor(TBColor.primary._20) +
                                 Text("/30").foregroundColor(TBColor.grayscale._5))
                                .font(.suit(.medium, size: 10))
                            }.padding(.vertical, 10)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    VStack(spacing: 0) {
                        TextField("최소 800자 이상의 글자수를 작성해주세요", text: .constant(""))
                            .padding(.top, 32)
                            .font(TBFont.body_4)
                    }.padding(.horizontal, 20)
                }
            }
            
            VStack(spacing: 0) {
                HStack(spacing: 1) {
                    Spacer()
                    (Text("0").foregroundColor(TBColor.primary._70) +
                     Text("/10,000").foregroundColor(TBColor.grayscale._20))
                    .font(.suit(.medium, size: 10))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                Divider()
                    .frame(minHeight: 1)
                    .overlay(TBColor.grayscale._5)
                
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
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
        }
        .ignoresSafeArea(edges: .top)
        .safeAreaInset(edge: .top) {
            TravelNewsPostHeaderView(isEnabledPostButton: .constant(false))
        }
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
                    TBIcon.before.iconSize(size: .medium)
                        .foregroundColor(.white)
                }.shadow(TBShadow._1)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                Text("여행소식 작성")
                    .font(TBFont.body_3)
                    .foregroundColor(.white)
                
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

#Preview {
    TravelNewsPostView()
}
