//
//  ProductDetailView.swift
//  MLStore
//
//  Created by Diego Sepulveda on 18-04-24.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    var body: some View {
        ScrollView() {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        MLText(product.condition, style: .textXSRegular)
                        Spacer()
                        HStack { //no data to fill rating
                            ForEach(0...4, id: \.self) { index in
                                Image(systemName: "star.fill")
                                    .imageScale(.small)
                                    .foregroundStyle(.tint)
                            }
                        }
                    }

                    MLText(product.title, style: .textMDMedium)
                    .lineLimit(3, reservesSpace: true)

                    if let official_store_name = product.officialStoreName {
                        MLText(official_store_name.uppercased(),
                               style: .textXSRegular)
                        .padding(5)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    }
                }

                HStack(alignment: .top) {
                    MLText("1/1", style: .textXSRegular)
                    .padding(5)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)

                    GeometryReader { geometry in
                        AsyncImage(url: URL(string: product.thumbnail ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: geometry.size.height) // Set size dynamically
                            case .failure:
                                Image(systemName: "xmark.circle")
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    .frame(width: 250, height: 250) // Set initial frame size
                    .clipped()

                    VStack {
                        Button(action: addToFavorites, label: {
                            Image(systemName: "heart")
                                .padding(10)
                        })
                        .background(.gray.opacity(0.2))
                        .clipShape(Circle())

                        ShareLink(item: URL(string: product.permalink ?? "")!,
                                  subject: Text("Mira este producto que encontré"),
                                  message: Text(product.title)) {
                            Image(systemName: "square.and.arrow.up")
                                .padding(10)
                                .background(.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                }

                VStack(alignment: .leading) {
                    if product.originalPrice > 0 {
                        MLText("$\(Int(product.originalPrice))")
                            .strikethrough()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    MLText("$\(Int(product.price))", style: .heading2XL)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if let installments = product.installments {
                        MLText(installments.description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.green)
                    }
                }

                VStack {
                    Button(action: buyProduct, label: {
                        Text("Comprar ahora")
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                    })
                    .buttonStyle(.borderedProminent)

                    Button(action: addToCart, label: {
                        Text("Agregar al carrito")
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                    })
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding()
        .navigationTitle("Detail")
    }

    func buyProduct() {
        //no action
        print("buy product...")
    }

    func addToCart() {
        //no action
        print("Add to cart...")
    }

    func addToFavorites() {
        //no action
        print("Add to favorites...")
    }
}

#Preview {
    do {
        let bundle = Bundle.main
        let path = bundle.path(forResource: "product_preview", ofType: "json")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!))

        let product = try JSONDecoder().decode(Product.self, from: jsonData!)
        return ProductDetailView(product: product)
    } catch {
        // Handle error if decoding fails
        fatalError("Failed to decode JSON: \(error)")
    }
}
