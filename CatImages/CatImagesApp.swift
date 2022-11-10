import SwiftUI

@main
struct CatImagesApp: App {
    
    // MARK: - Properties
    
    @AppStorage(Constants.darkLightMode) private var isDarkMode: Bool = false
    
    // MARK: - App Scene
    
    var body: some Scene {
        WindowGroup {
            CatListView()
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
        }
    }
    
}
