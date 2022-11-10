import SwiftUI

struct CatListView: View {
    
    // MARK: - Properties
    
    @StateObject var catVM: CatsViewModel = CatsViewModel()
    
    @State private var isSettingsMenuShowing: Bool = false
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                configureCatList()
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingsButton()
                }
            })
            .navigationTitle(Text(Constants.catsNavTitle))
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Helper Views

extension CatListView {
    
    @ViewBuilder
    private func settingsButton() -> some View {
        Button {
            isSettingsMenuShowing = true
        } label: {
            Image(systemName: Constants.gearImage)
                .imageScale(.large)
                .foregroundColor(Color(uiColor: .systemGray))
        }
        .sheet(isPresented: $isSettingsMenuShowing) {
            isSettingsMenuShowing = false
        } content: {
            UserSettingsView()
        }
    }
    
    @ViewBuilder
    private func configureCatList() -> some View {
        if catVM.isLoading {
            ActivityIndicatorView(isAnimating: $catVM.isLoading,
                                  style: .large,
                                  color: .systemMint)
        } else {
            List {
                ForEach(0..<catVM.cats.count, id: \.self) { index in
                    CatCellView(cat: catVM.cats[index])
                }
            }
            .listStyle(.plain)
        }
    }
    
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView()
    }
}
