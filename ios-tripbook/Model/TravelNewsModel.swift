//
//  TravelNewsModel.swift
//  ios-tripbook
//
//  Created by DDang on 2023/05/14.
//

import Foundation
import UIKit

/// 여행 소식 Data Model
/// - Author: 김민규
/// - Date: 2023/05/15
class TravelNewsModel: Document {}

/// 본인 여행 소식 Data Model
/// - Author: 김민규
/// - Date: 2023/05/20
class MyTravelNewsModel: TravelNewsModel {
    /// Data 상태
    enum Status {
        /// 승인
        case done
        
        /// 승인대기
        case waiting
    }
    
    /// Data 상태
    var status: Status
    /// 승인 날짜
    let approvedDate: Date?
    
    init(
        author: User,
        title: String,
        image: UIImage,
        likeCount: Int,
        commentCount: Int,
        isLiked: Bool,
        isSaved: Bool,
        createdAt: Date,
        status: Status,
        approvedDate: Date? = nil
    ) {
        self.status = status
        self.approvedDate = approvedDate
        
        super.init(
            author: author,
            title: title,
            image: image,
            likeCount: likeCount,
            commentCount: commentCount,
            isLiked: isLiked,
            isSaved: isSaved,
            createdAt: createdAt
        )
    }
    
    /// 승인된 날짜가 현재 날짜로부터 N일이 지났는지 체킹
    /// - Parameters:
    ///     - days: N일
    /// - Returns: 승인된 날짜가 현재 날짜로부터 N일이 지나면 `true`, 그렇지 않다면 `false`
    func isApprovedDateOver(days: Int) -> Bool {
        print(Calendar.current.dateComponents([.day], from: approvedDate!, to: .init()).day!)
        return Calendar.current.dateComponents([.day], from: approvedDate!, to: .init()).day! > days
    }
}

/// 여행 소식 Dummy Data Model
/// - Author: 김민규
/// - Date: 2023/05/15
class SampleTravelNewsModel: TravelNewsModel {
    /// 여행 소식 Dummy Data Model Initializer
    init() {
        super.init(
            author: .init(name: "서지혜", email: ""),
            title: "뚜벅이가 여행하기 좋은 장소 Top 5",
            image: UIImage(named: "SampleFeedThumbnail")!,
            likeCount: 1,
            commentCount: 2,
            isLiked: false,
            isSaved: false,
            createdAt: .init()
        )
    }
}
/// 본인 여행 소식 Dummy Data Model
/// - Author: 김민규
/// - Date: 2023/05/20
class SampleMyTravelNewsModel: MyTravelNewsModel {
    /// 본인 여행 소식 Dummy Data Model Initializer
    /// - Parameters:
    ///     - status: 상태
    init(_ status: Status) {
        super.init(
            author: .init(name: "서지혜", email: ""),
            title: "업무가 하기 싫을 때 기분 전환할 수 있는 바다 여행지 BEST3",
            image: UIImage(named: "SampleFeedThumbnail")!,
            likeCount: 1,
            commentCount: 2,
            isLiked: false,
            isSaved: false,
            createdAt: .init(),
            status: status,
            approvedDate: Calendar.current.date(byAdding: .day, value: -4, to: .init())!
        )
    }
}
