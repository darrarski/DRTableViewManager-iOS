Pod::Spec.new do |s|
  s.name         = 'DRTableViewManager'
  s.version      = '1.0.13'
  s.summary      = 'Object-oriented UITableViewDataSource and UITableViewDelegate protocols proxy'
  s.homepage     = 'https://github.com/darrarski/DRTableViewManager-iOS'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.source       = { :git => 'https://github.com/darrarski/DRTableViewManager-iOS.git', :tag => 'v1.0.13' }
  s.platform     = :ios
  s.ios.deployment_target = "7.0"
  s.source_files = 'DRTableViewManager'
  s.requires_arc = true
end
