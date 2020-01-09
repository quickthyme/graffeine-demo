// GraffeineLibrarySymbolProtection
//
// When using GraffeineView with storyboards, the class itself is seldom
// referenced in code directly. This causes SIL to strip the class symbols
// resulting in runtime errors. The following lines address this by simply
// making a public reference to the class, so that the linker is able to
// see that it should be left in.
import Graffeine
public let _GraffeineViewClass: GraffeineView.Type = GraffeineView.self
