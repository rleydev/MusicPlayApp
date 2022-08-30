//
//  Library.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 27.08.2022.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarDelegate?
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button {
                            print("button play first track")
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailedController(viewModel: self.track)
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(UIColor(named: "tint_pink")!))
                                .background(Color.init(UIColor(named: "button_background")!))
                                .cornerRadius(10)
                        }
                        Button {
                            print("reload tracks")
                            self.tracks = UserDefaults.standard.savedTracks()
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
                
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track)
                            .gesture(
                                LongPressGesture()
                                    .onEnded{ _ in
                                self.showingAlert = true
                                self.track = track
                            }
                                    .simultaneously(with: TapGesture()
                                                        .onEnded{ _ in
                                let keyWindow = UIApplication.shared.connectedScenes.filter({
                                                                $0.activationState == .foregroundActive
                                                            })
                                                                .map({ $0 as? UIWindowScene})
                                                                .compactMap({
                                                                $0
                                                            }).first?.windows.filter({ $0.isKeyWindow })
                                                                .first
                                let tabBarVC = keyWindow?.rootViewController as? MainTabBar
                                tabBarVC?.trackDetailedView.delegate = self
                                                            
                                self.track = track
                                self.tabBarDelegate?.maximizeTrackDetailedController(viewModel: self.track)
                            }))
                    }
                    .onDelete(perform: delete)
                }
            }
            .actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Are you sure you want to delete this song?"), buttons: [.destructive(Text("Delete"), action: {
                    self.delete(track: self.track)
                }), .cancel()])
            })
            .navigationBarTitle("Library")
        }
        .background(Color(UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)))
        
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let index = index else { return }
        tracks.remove(at: index)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
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

extension Library: TrackMovingDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let currentIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if currentIndex - 1 == -1 {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[currentIndex - 1]
        }
        self.track = nextTrack
        return nextTrack
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let currentIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if currentIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[currentIndex + 1]
        }
        self.track = nextTrack
        return nextTrack
    }
}
