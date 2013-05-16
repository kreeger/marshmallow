platform :ios, '6.0'
inhibit_all_warnings!

pod 'MagicalRecord', '~> 2.1'
pod 'CocoaLumberjack', '~> 1.6'
pod 'ObjectiveSugar', '~> 0.6.2'
pod 'ViewDeck', '~> 2.2.11'
pod 'BDKGeometry', path: '~/Code/kreeger/BDKGeometry'#'~> 1.3.0'
pod 'BDKKit', path: '~/Code/kreeger/BDKKit'
pod 'AFNetworking', '~> 1.2.0'
pod 'ISO8601DateFormatter', '~> 0.6'
pod 'CrittercismSDK', '~> 3.5.1'

pod 'IFBKThirtySeven', path: '~/Code/kreeger/IFBKThirtySeven'
# pod 'IFBKThirtySeven', git: 'git://github.com/kreeger/IFBKThirtySeven.git'

target :test, exclusive: true do
  link_with 'MarshmallowTests'
  pod 'Kiwi'
end
