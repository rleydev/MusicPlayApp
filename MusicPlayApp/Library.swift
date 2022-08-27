//
//  Library.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 27.08.2022.
//

import SwiftUI
import URLImage

struct Library: View {
    
    var tracks = UserDefaults.standard.savedTracks()
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button {
                            print("button")
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(UIColor(named: "tint_pink")!))
                                .background(Color.init(UIColor(named: "button_background")!))
                                .cornerRadius(10)
                        }
                        Button {
                            print("button2")
                        } label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(UIColor(named: "tint_pink")!))
                                .background(Color.init(UIColor(named: "button_background")!))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .frame(height: 65)
                Divider().padding(.leading).padding(.trailing)
                
                List(tracks) { track in
                    LibraryCell(cell: track)
                }
//                .background(Color(UIColor.lightGray))
            }
            .navigationBarTitle("Library")
        }
        
    }
}



struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(2)
            }
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
