platform :ios, '7.0'
inhibit_all_warnings!

pod 'MagicalRecord', '~> 2.1'
pod 'CocoaLumberjack', '~> 1.6'
pod 'Masonry'
pod 'BDKGeometry', path: '~/Code/kreeger/BDKGeometry'
pod 'BDKKit', path: '~/Code/kreeger/BDKKit'
pod 'AFNetworking', '~> 1.3.1'
pod 'PHFComposeBarView', '~> 1.1.1'
pod 'AGMedallionView', git: 'git://github.com/kreeger/AGMedallionView.git', commit: '557d3eda'
pod 'Reveal-iOS-SDK'
pod 'FontasticIcons', '~> 0.5.0'
pod 'IFBKThirtySeven', path: '~/Code/kreeger/IFBKThirtySeven'
# pod 'IFBKThirtySeven', git: 'git://github.com/kreeger/IFBKThirtySeven.git'

target :test, exclusive: true do
  link_with 'MarshmallowTests'
  pod 'Kiwi', '~> 2.2'
end
