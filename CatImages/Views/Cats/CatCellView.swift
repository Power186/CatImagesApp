import SwiftUI

struct CatCellView: View {
    
    // MARK: - Properties
    
    let cat: Cat
    
    private let spacing: CGFloat = 16
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: spacing) {
            AsyncImageView(imageUrl: cat.catId ?? "",
                           id: cat.id)
        }
        .padding(.all, spacing)
    }
}

// MARK: - Preview

struct CatCellView_Previews: PreviewProvider {
    static var previews: some View {
        CatCellView(cat: Cat(catId: "Rn6xqsiHb9B7qgLw"))
    }
}
