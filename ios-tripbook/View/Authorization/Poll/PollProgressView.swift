//
//  PollProgressView.swift
//  ios-tripbook
//
//  Created by 박상현 on 2023/04/29.
//

import SwiftUI

struct PollProgressView: View {
    @State var currentPage: Int = 1
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5) { i in
                if currentPage - 1 > i {
                    PollProgressRectangleView(barColor: .red)
                } else if currentPage - 1 == i {
                    PollProgressRectangleView(barColor: .red).opacity(0.5)
                } else {
                    PollProgressRectangleView(barColor: .gray).opacity(0.3)
                }
            }
            Spacer()
        }
    }
}

struct PollProgressRectangleView: View {
    var barColor: Color = .orange
    var body: some View {
        Rectangle()
            .fill(barColor)
            .frame(width: 44, height: 9)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 1))
        
    }
}

struct PollProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PollProgressView()
    }
}
