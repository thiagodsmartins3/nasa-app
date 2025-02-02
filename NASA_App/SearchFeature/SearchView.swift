//
//  SearchView.swift
//  NASA_App
//
//  Created by Thiago dos Santos Martins on 02/02/25.
//

import SwiftUI

struct SearchView: View {
    @State private var inputText: String = ""
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
              Image(systemName: "person.circle")
                .resizable()
                .frame(width: 24, height: 24)
                TextField("", text: $inputText)
            }
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            Spacer()
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height > 100 {
                        isPresented = false
                    }
                }
        )
    }
}
