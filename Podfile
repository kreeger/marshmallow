platform :ios, '7.0'
inhibit_all_warnings!

pod 'MagicalRecord', '~> 2.1'
pod 'CocoaLumberjack', '~> 1.6'
pod 'ObjectiveSugar', '~> 0.6.2'
pod 'ViewDeck', '~> 2.2.11'
pod 'Masonry'
pod 'BDKGeometry', path: '~/Code/kreeger/BDKGeometry'
pod 'BDKKit', path: '~/Code/kreeger/BDKKit'
pod 'AFNetworking', '~> 1.3.1'
pod 'PHFComposeBarView', '~> 1.1.1'
pod 'Reveal-iOS-SDK'

pod 'IFBKThirtySeven', path: '~/Code/kreeger/IFBKThirtySeven'
# pod 'IFBKThirtySeven', git: 'git://github.com/kreeger/IFBKThirtySeven.git'

target :test, exclusive: true do
  link_with 'MarshmallowTests'
  pod 'Kiwi'
end
