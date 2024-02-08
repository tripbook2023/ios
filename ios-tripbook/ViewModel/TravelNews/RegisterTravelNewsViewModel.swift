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
    @Published var tempItem: TravelNewsModel?
    @Published var isShowTemporaryStorageListView = false
    @Published var isShowSearchLocationView = false
    @Published var location: LocationInfo?
    
    var title: String = ""
    var content: String = ""
    var thumbnail: String?
    var fileIds = [Int: String]()
    
    init(apiManager: APIManagerable = TBAPIManager()) {
        self.apiManager = apiManager
    }
    
    func fatchTempList() {
        Task {
            do {
                let api = TBMemberAPI.selectTemp()
                let result = try await apiManager.request(api, type: [ContentResponse].self, encodingType: .url).map { $0.toDomain }
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
                    fileIds: fileIds.keys.map { $0 },
                    thumbnail: thumbnail,
                    locationList: location
                )
                _ = try await apiManager.request(api, encodingType: .json)
                if type == .temp {
                    fatchTempList()
                }
            } catch {
                
            }
        }
    }
    
    func setImage(_ imageData: Data) async -> (String?, Int?) {
        do {
            let api = TBCommonAPI.upload(image: imageData)
            let result = try await apiManager.upload(api, type: ImageUploadResponse.self).toDomain
            await MainActor.run {
                fileIds[result.id] = result.url
            }
            return (result.url, result.id)
        } catch {
            return (nil, nil)
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
    
    func readHTML(htmlContent: String) -> NSAttributedString? {
        let regex = try? NSRegularExpression(pattern: "<img id=[^>]*>", options: [])
        
        guard let matches = regex?.matches(in: htmlContent, options: [], range: .init(location: 0, length: htmlContent.count)) else { return nil }
        let stringRanges = matches.compactMap { r in
            Range(r.range, in: htmlContent)
        }
        
        guard var attributedString = htmlContent.toAttributedString() else { return nil }
        var index = 0
        
        attributedString.enumerateAttribute(
            .init("NSAttachment"),
            in: NSRange(location: 0, length: attributedString.length), options: []
        ) { value, range, _ in
            if value == nil { return }
            let stringRange = stringRanges[index]
            
            if let urlRange = htmlContent[stringRange].range(of: "http(s)://[a-zA-Z0-9@:%._+~#=/-]{1,}", options: .regularExpression),
               let idRange = htmlContent[stringRange].range(of: "id=[0-9]{1,}", options: .regularExpression),
               let id = htmlContent[stringRange][idRange].split(separator: "=").last 
            {
                let imageUrl = htmlContent[stringRange][urlRange]
                
                let mutable = NSMutableAttributedString(attributedString: attributedString)
                mutable.addAttribute(.init("ID"), value: Int(id)!, range: range)
                attributedString = NSAttributedString(attributedString: mutable)
                
                fileIds[Int(id)!] = String(imageUrl)
                index += 1
            }
        }
        
        return attributedString
    }
}
