// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Art Objects
  public static let artObjects = L10n.tr("Localizable", "ArtObjects")
  /// Author
  public static let author = L10n.tr("Localizable", "Author")
  /// Collections
  public static let collections = L10n.tr("Localizable", "Collections")
  /// Description
  public static let description = L10n.tr("Localizable", "Description")
  /// Details
  public static let details = L10n.tr("Localizable", "Details")
  /// Dimensions
  public static let dimensions = L10n.tr("Localizable", "Dimensions")
  /// Something technical went wrong. Please, try again later.
  public static let genericLoadErrorDescription = L10n.tr("Localizable", "GenericLoadErrorDescription")
  /// Count: %@
  public static func itemsCount(_ p1: Any) -> String {
    return L10n.tr("Localizable", "ItemsCount", String(describing: p1))
  }
  /// Name
  public static let name = L10n.tr("Localizable", "Name")
  /// Server error
  public static let serverError = L10n.tr("Localizable", "ServerError")
  /// Sorry...
  public static let sorry = L10n.tr("Localizable", "Sorry")
  /// Try again
  public static let tryAgain = L10n.tr("Localizable", "TryAgain")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
