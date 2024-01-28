//
//  RegisterTravelNewsViewModel.swift
//  ios-tripbook
//
//  Created by 이시원 on 12/29/23.
//

import Foundation

final class RegisterTravelNewsViewModel: ObservableObject {
    private var apiManager: APIManagerable
    
    @Published var tempItems: [TravelNewsModel] = []
    @Published var isShowTemporaryStorageListView = false
    @Published var isShowSearchLocationView = false
    @Published var location: LocationInfo?
    
    var title: String = ""
    var content: String = ""
    var thumbnail: String?
    var fileIds = [Int]()
    
    init(apiManager: APIManagerable = TBAPIManager()) {
        self.apiManager = apiManager
    }
    
    func fatchTempList() {
        Task {
            do {
                let api = TBMemberAPI.selectTemp()
                let result = try await apiManager.request(api, type: [ContentResponse].self).map { $0.toDomain }
                await MainActor.run {
                    tempItems = result
                }
            } catch {
                // 에러처리
            }
           
        }
    }
    
    func save(_ type: PostSaveType) {
        Task {
            do {
                let api = TBTravelNewsAPI.save(
                    saveType: type,
                    id: nil,
                    title: title,
                    content: content,
                    fileIds: fileIds,
                    thumbnail: thumbnail,
                    locationList: location
                )
                _ = try await apiManager.request(api)
            } catch {
                
            }
        }
    }
    
    func setImage(_ imageData: Data) async -> String? {
        do {
            let api = TBCommonAPI.upload(image: imageData)
            let result = try await apiManager.upload(api, type: ImageUploadResponse.self).toDomain
            await MainActor.run {
                fileIds.append(result.id)
            }
            return result.url
        } catch {
            return nil
        }
    }
    
    func deleteTemp(index: Int) {
        Task {
            do {
                let id = tempItems[index].id
                let api = TBTravelNewsAPI.delete(id: id)
                _ = try await apiManager.request(api, encodingType: .url)
                fatchTempList()
            } catch {
                
            }
        }
    }
}
