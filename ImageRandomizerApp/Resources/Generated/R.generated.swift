//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 3 colors.
  struct color {
    /// Color `blue`.
    static let blue = Rswift.ColorResource(bundle: R.hostingBundle, name: "blue")
    /// Color `light-black`.
    static let lightBlack = Rswift.ColorResource(bundle: R.hostingBundle, name: "light-black")
    /// Color `light-grey`.
    static let lightGrey = Rswift.ColorResource(bundle: R.hostingBundle, name: "light-grey")
    
    /// `UIColor(named: "blue", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blue(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blue, compatibleWith: traitCollection)
    }
    
    /// `UIColor(named: "light-black", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lightBlack(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lightBlack, compatibleWith: traitCollection)
    }
    
    /// `UIColor(named: "light-grey", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lightGrey(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lightGrey, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 2 images.
  struct image {
    /// Image `info-icon`.
    static let infoIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "info-icon")
    /// Image `logo`.
    static let logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "logo")
    
    /// `UIImage(named: "info-icon", bundle: ..., traitCollection: ...)`
    static func infoIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.infoIcon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "logo", bundle: ..., traitCollection: ...)`
    static func logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logo, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    /// Nib `ImageDetailsViewController`.
    static let imageDetailsViewController = _R.nib._ImageDetailsViewController()
    /// Nib `ImageTableViewCell`.
    static let imageTableViewCell = _R.nib._ImageTableViewCell()
    /// Nib `ImagesListViewController`.
    static let imagesListViewController = _R.nib._ImagesListViewController()
    
    /// `UINib(name: "ImageDetailsViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.imageDetailsViewController) instead")
    static func imageDetailsViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.imageDetailsViewController)
    }
    
    /// `UINib(name: "ImageTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.imageTableViewCell) instead")
    static func imageTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.imageTableViewCell)
    }
    
    /// `UINib(name: "ImagesListViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.imagesListViewController) instead")
    static func imagesListViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.imagesListViewController)
    }
    
    static func imageDetailsViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.imageDetailsViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    static func imageTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ImageTableViewCell? {
      return R.nib.imageTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ImageTableViewCell
    }
    
    static func imagesListViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.imagesListViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `ImageTableViewCell`.
    static let imageTableViewCell: Rswift.ReuseIdentifier<ImageTableViewCell> = Rswift.ReuseIdentifier(identifier: "ImageTableViewCell")
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _ImageDetailsViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "ImageDetailsViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _ImageTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = ImageTableViewCell
      
      let bundle = R.hostingBundle
      let identifier = "ImageTableViewCell"
      let name = "ImageTableViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ImageTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ImageTableViewCell
      }
      
      fileprivate init() {}
    }
    
    struct _ImagesListViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "ImagesListViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
