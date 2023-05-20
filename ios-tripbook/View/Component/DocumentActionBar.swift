//
//  DocumentActionBar.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/18.
//

import SwiftUI

/// Document Button Event Delegate
/// - Author: 김민규
/// - Date: 2023/05/20
protocol DocumentActionBarDelegate {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapShareButton()
    func didTapSaveButton()
}

/// Document Data에 대해 좋아요, 댓글, 공유, 저장의 Action에 대한 View
/// - Author: 김민규
/// - Date: 2023/05/20
struct DocumentActionBar<T: Document>: View {
    /// Document Data
    @Binding var data: T
    /// Delegate
    var delegate: DocumentActionBarDelegate?
    
    /// 공유 가능 여부
    var canShare: Bool
    
    /// Based Text Color
    var color: Color
    
    /// Document Data Action View Initializer
    init(
        _ data: Binding<T>,
        delegate: DocumentActionBarDelegate? = nil,
        canShare: Bool = false,
        color: Color = .primary
    ) {
        self._data = data
        self.delegate = delegate
        self.canShare = canShare
        self.color = color
    }
    
    var body: some View {
        HStack {
            HStack(spacing: 27) {
                CountingToggleButton(
                    image: self.data.isLiked ? Image(systemName: "heart.fill") : Image(systemName: "heart"),
                    imageColor: self.data.isLiked ? .pink : self.color,
                    labelColor: self.color,
                    isToggled: self.$data.isLiked,
                    count: self.$data.likeCount
                ) {
                    self.delegate?.didTapLikeButton()
                }
                TextToggleButton(
                    image: Image(systemName: "text.bubble"),
                    imageColor: self.color,
                    labelColor: self.color,
                    isToggled: .constant(false),
                    text: String(self.data.commentCount)
                ) {
                    self.delegate?.didTapCommentButton()
                }
            }
            
            Spacer()
            
            HStack(spacing: 7) {
                if canShare {
                    Button(action: {
                        self.delegate?.didTapShareButton()
                    }) {
                        Image(systemName: "arrowshape.turn.up.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(self.color)
                    }
                }
                
                ToggleButton(
                    image: self.data.isSaved ? Image(systemName: "bookmark.fill") : Image(systemName: "bookmark"),
                    imageColor: self.data.isSaved ? .yellow : self.color,
                    isToggled: self.$data.isSaved
                ) {
                    self.delegate?.didTapSaveButton()
                }
            }
        }
    }
}

struct DocumentActionBar_Previews: PreviewProvider {
    static var previews: some View {
        DocumentActionBar(.constant(SampleTravelNewsModel()))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
