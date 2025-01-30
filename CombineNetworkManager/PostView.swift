//
//  PostView.swift
//  CombineNetworkManager
//
//  Created by Muneesh Kumar on 26/01/25.
//

import SwiftUI

struct PostView: View {
    var post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(post.title ?? "")
                .font(.headline)
            Text(post.body ?? "")
        }
    }
}

#Preview {
    PostView(post: Post(userID: nil, id: nil, title: nil, body: nil))
}
