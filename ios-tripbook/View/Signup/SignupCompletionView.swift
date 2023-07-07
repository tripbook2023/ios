//
//  SignupCompletionView.swift
//  ios-tripbook
//
//  Created by DDang on 7/1/23.
//

import SwiftUI

struct SignupCompletionView: View {
    @State var navigationTrigger: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(width: 140, height: 140)
                .foregroundColor(TBColor.grayscale.levels[2])
            
            Text("트립북 가입을 축하드려요!")
                .font(TBFont.heading_1)
                .foregroundColor(TBColor.grayscale.levels[9])
                .padding(.top, 16)
            
            Text("나만의 소중한 여행기록을 작성해보세요.")
                .font(TBFont.body_4)
            
            NavigationLink(isActive: self.$navigationTrigger, destination: {
                RootView()
            }, label: {
                EmptyView()
            })
        }
        .navigationBarHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.navigationTrigger = true
            }
        }
    }
}

struct SignupCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        SignupCompletionView()
    }
}
