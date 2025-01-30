//
//  ContentView.swift
//  CombineNetworkManager
//
//  Created by Muneesh Kumar on 26/01/25.
//

import SwiftUI

struct PostsView: View {
    @StateObject private var viewModel: PostsViewModel = PostsViewModel()
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            ProgressView()
        }
        .frame(height: 50)
        .onAppear {
            viewModel.fetchPosts()
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.posts, id: \.id) { post in
                    PostView(post: post)
                }
                if viewModel.isMoreRecords {
                    lastRowView
                }
            }
            .refreshable {
                viewModel.resetValues()
                viewModel.fetchPosts()
            }
        }
        .padding()
        .onAppear {
            self.viewModel.fetchPosts()
        }
    }
}



#Preview {
    PostsView()
}

