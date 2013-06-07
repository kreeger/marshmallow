platform :ios, '6.0'
inhibit_all_warnings!

pod 'MagicalRecord', '~> 2.1'
pod 'CocoaLumberjack', '~> 1.6'
pod 'ObjectiveSugar', '~> 0.6.2'
pod 'ViewDeck', '~> 2.2.11'
pod 'BDKGeometry', git: 'git://github.com/kreeger/BDKGeometry.git'
pod 'BDKKit', git: 'git://github.com/kreeger/BDKKit.git'
pod 'AFNetworking', '~> 1.2.0'
pod 'ISO8601DateFormatter', '~> 0.6'
pod 'CrittercismSDK', '~> 3.5.1'

pod 'IFBKThirtySeven', path: '~/Code/kreeger/IFBKThirtySeven'
# pod 'IFBKThirtySeven', git: 'git://github.com/kreeger/IFBKThirtySeven.git'
# pod 'IFBKSharedComponents', path: '~/Code/kreeger/IFBKSharedComponents'
# pod 'IFBKSharedComponents', git: 'git://github.com/kreeger/IFBKSharedComponents.git'

target :test, exclusive: true do
  link_with 'MarshmallowTests'
  pod 'Kiwi'
end
