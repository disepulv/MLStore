//
//  ProductListCellView.swift
//  MLStore
//
//  Created by Diego Sepulveda on 19-04-24.
//

import SwiftUI

struct ProductListCellView: View {
    var product: Product
    var body: some View {
        HStack {
            GeometryReader { geometry in
                AsyncImage(url: URL(string: product.thumbnail ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Placeholder while loading
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height) // Set size dynamically
                    case .failure:
                        Image(systemName: "xmark.circle") // Placeholder on failure
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .frame(width: 100, height: 100) // Set initial frame size
            .clipped()
            VStack (alignment: .leading, spacing: 10) {
                MLText(product.title, style: .textXSRegular)
                    .lineLimit(3, reservesSpace: true)
                HStack { //no data to fill rating
                    ForEach(0...4, id: \.self) { index in
                        Image(systemName: "star.fill")
                            .imageScale(.small)
                            .foregroundStyle(.tint)
                    }
                }
                if product.originalPrice > 0 {
                    MLText("$\(Int(product.originalPrice))")
                        .strikethrough()
                }
                MLText("$\(Int(product.price))",
                       style: .textLGBold)

                if let installments = product.installments {
                    MLText(installments.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.green)
                }
            }
        }
    }
}

#Preview {
    do {
        let bundle = Bundle.main
        let path = bundle.path(forResource: "product_preview", ofType: "json")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!))

        let product = try JSONDecoder().decode(Product.self, from: jsonData!)
        return ProductListCellView(product: product)
    } catch {
        // Handle error if decoding fails
        fatalError("Failed to decode JSON: \(error)")
    }
}
