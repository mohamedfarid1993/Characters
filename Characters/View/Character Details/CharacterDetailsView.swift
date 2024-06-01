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
                VStack(alignment: .leading, spacing: 24) {
                    CharacterImageView(geometry)
                    VStack(spacing: 0) {
                        HStack {
                            CharacterName()
                            Spacer()
                            Status()
                        }
                        HStack {
                            SpeciesGenderText().accessibility(identifier: AccessibilityIdentifiers.speciesGenderText)
                            Spacer()
                        }
                    }.padding(.horizontal)
                    LocationText().padding(.horizontal).accessibility(identifier: AccessibilityIdentifiers.locationText)
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
        }.accessibility(identifier: AccessibilityIdentifiers.backButton)
    }
    
    // MARK: Character Image View
    
    private func CharacterImageView(_ geometry: GeometryProxy) -> some View {
        KFImage(URL(string: character.image))
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.width)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .clipped()
            .accessibility(identifier: AccessibilityIdentifiers.characterImageView)
    }
    
    // MARK: Character Name
    
    private func CharacterName() -> some View {
        Text(self.character.name)
            .fontWeight(.semibold)
            .font(.title2)
            .foregroundStyle(Color(uiColor: Theme.Colors.titlesDarkPurple))
            .accessibility(identifier: AccessibilityIdentifiers.characterName)
    }
    
    // MARK: Status
    
    private func Status() -> some View {
        Text(self.character.status.rawValue)
            .frame(height: 30)
            .multilineTextAlignment(.center)
            .padding()
            .background(RoundedRectangle(cornerRadius: 15)
                .fill(Color.cyan).frame(height: 30)
            )
            .frame(height: 30)
            .accessibility(identifier: AccessibilityIdentifiers.statusText)
    }
    
    // MARK: Species & Gender Text
    
    private func SpeciesGenderText() -> some View {
        Text(self.character.species + " •")
            .foregroundStyle(Color(uiColor: Theme.Colors.titlesDarkPurple))
        +
        Text(" " + self.character.gender.rawValue)
            .foregroundStyle(Color(uiColor: Theme.Colors.subtitlesLightPurple))
    }
    
    // MARK: Location
    
    private func LocationText() -> some View {
        Text("Location: ")
            .foregroundStyle(Color(uiColor: Theme.Colors.titlesDarkPurple))
            .fontWeight(.semibold)
            .font(.title3)
        +
        Text(self.character.location.name)
            .foregroundStyle(Color(uiColor: Theme.Colors.titlesDarkPurple))
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
