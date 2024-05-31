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
            ZStack(alignment: .topLeading) {
                VStack(spacing: 24) {
                    CharacterImageView(geometry)
                    HStack {
                        CharacterName()
                        Spacer()
                        Status()
                    }
                    .padding(.horizontal)
                }
                BackButton()
            }
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - Subviews

extension CharacterDetailsView {
    
    // MARK: - Back Button
    
    private func BackButton() -> some View {
        Button(action: {
            self.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
                .background(Circle().frame(width: 40, height: 40).foregroundStyle(.white))
                .padding(.leading, 24)
                .padding(.top, 64)
        }
    }
    
    // MARK: Character Image View
    
    private func CharacterImageView(_ geometry: GeometryProxy) -> some View {
        KFImage(URL(string: character.image))
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.width)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .clipped()
    }
    
    // MARK: Character Name
    
    private func CharacterName() -> some View {
        Text(self.character.name)
            .fontWeight(.semibold)
            .font(.title2)
            .foregroundStyle(Color(uiColor: Theme.Colors.titlesDarkPurple))
    }
    
    // MARK: Status
    
    private func Status() -> some View {
        Text(self.character.status.rawValue)
            .frame(height: 30)
            .multilineTextAlignment(.center)
            .padding()
            .background(RoundedRectangle(cornerRadius: 15)
                .fill(Color.cyan)
                .frame(height: 30)
            )
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
