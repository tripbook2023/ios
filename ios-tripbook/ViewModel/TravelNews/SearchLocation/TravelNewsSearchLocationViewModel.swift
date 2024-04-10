//
//  TravelNewsSearchLocationViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 2023/10/15.
//

import Foundation
import Combine

@MainActor
class TravelNewsSearchLocationViewModel: ObservableObject {
    private let apiManager: APIManagerable
    private var task: Task<Void, Error>? = nil
    private var anyCancellable = Set<AnyCancellable>()
    
    @Published var searchKeyword: String = ""
    @Published var locationInfos: [LocationInfo] = []
    @Published var selectionIndex: Int?
    
    init(apiManager: APIManagerable = TBAPIManager()) {
        self.apiManager = apiManager
        $searchKeyword
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] keyword in
            self?.selectionIndex = nil
            self?.task?.cancel()
            self?.task = Task {
                await self?.searchLocation(keyword: keyword)
            }
        }.store(in: &anyCancellable)
    }
    
    private func searchLocation(keyword: String) async {
        let result = try? await apiManager.request(
            KakaoLocationSearchAPI.locationSearch(
                query: keyword
            ),
            type: LocationSearchResponse.self,
            encodingType: .url
        ).toDomain
        
        locationInfos = result ?? []
    }
}
