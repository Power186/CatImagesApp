import SwiftUI

struct AsyncImageView: View {
    
    // MARK: - Properties
    
    @StateObject private var asyncImageVM: AsyncImageViewModel
    
    // MARK: - Init
    
    init(imageUrl: String,
         id: String) {
        _asyncImageVM = StateObject(wrappedValue: AsyncImageViewModel(urlString: imageUrl,
                                                                      catIdKey: id))
    }
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            if asyncImageVM.isLoading {
                HStack {
                    Spacer()
                    ActivityIndicatorView(isAnimating: $asyncImageVM.isLoading,
                                          style: .medium,
                                          color: .systemMint)
                    Spacer()
                }
            } else if let renderedImage = asyncImageVM.image {
                fetchedImage(renderedImage)
            }
        }
    }
}

// MARK: - Helper Views

extension AsyncImageView {
    
    @ViewBuilder
    private func fetchedImage(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .renderingMode(.original)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .aspectRatio(contentMode: .fit)
    }
    
}

// MARK: - Preview

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(imageUrl: "Rn6xqsiHb9B7qgLw", id: UUID().uuidString)
    }
}
