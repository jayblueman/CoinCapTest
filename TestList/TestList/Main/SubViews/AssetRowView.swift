//
//  AssetRowView.swift
//  TestList
//
//  Created by Adrián Juhász on 2024. 12. 09..
//

import SwiftUI

struct AssetRowView: View {
    let asset: Asset

    var body: some View {
        HStack(spacing: 16) {
            if let imageURL = URL(string: AssetURLProvider.icon(asset.symbol).urlString) {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 50)
                }
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
            }


            VStack(alignment: .leading, spacing: 4) {
                Text(asset.name.capitalized)
                    .font(Font.system(size: 17, weight: .regular))
                Text(asset.symbol.uppercased())
                    .font(Font.system(size: 17, weight: .regular))
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 0) {
                Text(asset.formattedPrice)
                    .font(Font.system(size: 17, weight: .bold))
                HStack(spacing: 4) {

                    Image(asset.changePercent24Hr?.hasPrefix("-") == true ? "IconTriangleRed" : "IconTriangleGreen")
                        .resizable()
                        .frame(width: 8, height: 8)

                    Text(asset.formattedPercent)
                        .font(Font.system(size: 14, weight: .bold))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(asset.changePercent24Hr?.hasPrefix("-") == true ? Color.red : Color.green)
                        )
                        .foregroundColor(.white)
                }
            }

            Rectangle()
                .fill(Color(.systemGray4))
                .frame(width: 1, height: 70)

            Button(action: {
                // Button action here
                print("\(asset.name) button tapped")
            }) {
                Image("IconDownArrow")
                    .resizable()
                    .frame(width: 14, height: 22)
            }
        }
        .frame(height: 74)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.white))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.31), radius: 0, x: 0, y: 1)
    }
}
