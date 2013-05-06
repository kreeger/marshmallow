platform :ios, '6.0'
inhibit_all_warnings!

pod 'MagicalRecord', '~> 2.1'
pod 'CocoaLumberjack', '~> 1.6'
pod 'ObjectiveSugar', '~> 0.6.2'
pod 'BDKGeometry', path: '~/Code/kreeger/BDKGeometry'#'~> 1.3.0'
pod 'BDKKit', path: '~/Code/kreeger/BDKKit'
pod 'AFNetworking', '~> 1.2.0'
pod 'ISO8601DateFormatter', '~> 0.6'
pod 'CrittercismSDK'

pod 'BDKThirtySeven', path: '~/Code/kreeger/BDKThirtySeven'
# pod 'BDKThirtySeven', git: 'git://github.com/kreeger/BDKThirtySeven.git'

target :test, exclusive: true do
  link_with 'MarshmallowTests'
  pod 'Kiwi'
end
