platform :ios, '7.0'
inhibit_all_warnings!

pod 'CocoaLumberjack', '~> 1.6'
pod 'Masonry'
pod 'BDKGeometry', path: '~/Code/kreeger/BDKGeometry'
pod 'BDKKit', git: 'git://github.com/kreeger/BDKKit.git', commit: '598dfb'
pod 'AFNetworking', '~> 2.0.3'
pod 'PHFComposeBarView', '~> 1.1.1'
pod 'AGMedallionView', git: 'git://github.com/kreeger/AGMedallionView.git', commit: '557d3eda'
pod 'Reveal-iOS-SDK', '~> 0.9.1'
pod 'FontasticIcons', '~> 0.5.0'
pod 'IFBKThirtySeven', path: '~/Code/kreeger/IFBKThirtySeven'

target :test, exclusive: true do
  link_with 'MarshmallowTests'
  pod 'Kiwi', '~> 2.2'
end
