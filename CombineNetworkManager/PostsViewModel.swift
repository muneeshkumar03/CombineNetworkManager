//
//  PostsViewModel.swift
//  CombineNetworkManager
//
//  Created by Muneesh Kumar on 26/01/25.
//

import Foundation
import Combine

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var limit: Int = 10
    @Published var start: Int = 1
    @Published var isLoading: Bool = false
    @Published var isMoreRecords: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    func fetchPosts() {
        isLoading = true
        NetworkManager.shared.getData(url: EndPoint.posts(limit: limit, start: start), response: [Post].self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { posts in
                if posts.isEmpty {
                    self.isMoreRecords = false
                    return
                } else {
                    self.start += self.limit
                    self.isMoreRecords = true
                    self.posts += posts
                }
            })
            .store(in: &cancellables)
    }
    
    func resetValues() {
        self.posts.removeAll()
        self.start = 1
        isMoreRecords = true
    }
}
