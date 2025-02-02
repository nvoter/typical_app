//
//  MainContentView.swift
//  TypicalApp
//
//  Created by Анастасия on 15.07.2024.
//

import SwiftUI

struct MainContentView: View {
    @State private var cards: [Card] = [
        Card(title: "Card 1", description: "Description for card 1", tags: ["Tag1", "Tag2"]),
        Card(title: "Card 2", description: "Description for card 2", tags: ["Tag3"])
    ]
    
    @State private var showModal = false
    @State private var selectedTag: String = "All"
    @State private var searchText: String = ""
    
    var tags: [String] {
        Array(Set(cards.flatMap { $0.tags })).sorted()
    }
    var filteredCards: [Card] {
        let filteredByTag = selectedTag == "All"
        ? cards
        : cards.filter { $0.tags.contains(selectedTag) }
        
        if searchText.isEmpty {
            return filteredByTag
        } else {
            return filteredByTag.filter {
                $0.title.contains(searchText) || $0.description.contains(searchText)
            }
            
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Filter by Tag", selection: $selectedTag) {
                    Text("All").tag("All")
                    ForEach(tags, id: \.self) { tag in
                        Text(tag).tag(tag)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                TextField ("Search", text: $searchText)
                    .padding()
                    .background (Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                List {
                    ForEach(filteredCards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                // Открытие подробного просмотра карточки
                            }
                            .swipeActions(allowsFullSwipe: true) {
                                Button {
                                    withAnimation {
                                        deleteCard(card.id)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                            .tint(.red)
                    }
                }
            }
            .navigationBarTitle("Cards")
            .navigationBarItems (trailing: Button (action: {
                showModal.toggle()
            }) {
                Image (systemName: "plus")
            })
            .sheet (isPresented: $showModal) {
                AddCardView(cards: $cards)
            }
        }
    }
    
    func deleteCard(_ id: UUID) {
        if let ind = cards.firstIndex(where: {
            $0.id == id
        }) {
            cards.remove(at: ind)
        }
    }
}

struct AddCardView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var cards: [Card]
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var tags: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Card Information")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Tags (comma separated)", text: $tags)
                }
                
                Button("Add Card") {
                    var tagList = tags.split(separator: ",").map {
                        String($0).trimmingCharacters (in: .whitespaces)
                    }.filter {
                        $0 != "All"
                    }
                    
                    let newCard = Card(title: title, description: description, tags: tagList)
                    cards.append(newCard)
                    title = ""
                    description = ""
                    tags = ""
                }
                
            }
            .navigationBarTitle("Add Card")
            .navigationBarItems (trailing: Button("Done") {
                dismiss()
            })
        }
    }
}

#Preview {
    MainContentView()
}
