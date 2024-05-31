//
//  CharacterDetailsView.swift
//  Characters
//
//  Created by Mohamed Farid on 31/05/2024.
//

import SwiftUI
import Kingfisher

struct CharacterDetailsView: View {
    
    // MARK: Properties
    
    var character: Character
    
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                KFImage(URL(string: character.image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .clipped()
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - Methods

extension CharacterDetailsView {
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    CharacterDetailsView(character: Character.fake())
}
