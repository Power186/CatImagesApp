import SwiftUI

struct UserSettingsView: View {
    
    // MARK: - Properties
    
    @AppStorage(Constants.darkLightMode) private var isDarkMode: Bool = false
    @Environment(\.presentationMode) var presentation
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    lightDarkModePicker()
                        .onChange(of: isDarkMode) { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                presentation.wrappedValue.dismiss()
                            }
                        }
                } header: {
                    Text(Constants.modeTitle)
                }
            }
            .navigationTitle(Text(Constants.settingsTitle))
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

// MARK: - Helper Views

extension UserSettingsView {
    
    @ViewBuilder
    private func lightDarkModePicker() -> some View {
        Picker(selection: $isDarkMode) {
            Text(Constants.lightMode)
                .fontWeight(.semibold)
                .tag(false)
            Text(Constants.darkMode)
                .fontWeight(.semibold)
                .tag(true)
        } label: { }
        .pickerStyle(.inline)
    }
    
}

// MARK: - Preview

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView()
    }
}

