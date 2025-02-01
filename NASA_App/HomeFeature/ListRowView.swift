//
//  ListRowView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 31/01/25.
//

import SwiftUI

struct ListRowView: View {
    let item: ApodModelElement
    
    var body: some View {
        VStack {
            Text(item.date ?? "")
            Text(item.title ?? "")
            Text(item.explanation ?? "")
            Text(item.url ?? "")
        }
    }
}
