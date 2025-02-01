//
//  ListRowView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 31/01/25.
//

import SwiftUI
import RequestLib

struct ListRowView: View {
    let item: ApodModelElement
    
    var body: some View {
        VStack(spacing: 20) {
            Text(item.title ?? "")
            Text(item.date ?? "")
            Text(item.explanation ?? "")
            AsyncImage(url: URL(string: item.url ?? "")) {
                image in
                image.image?.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
            }
        }
    }
}
