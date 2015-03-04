Pod::Spec.new do |s|
  s.name         = 'DRTableViewManager'
  s.version      = '1.0.1'
  s.summary      = 'Block-based implementation of UITableViewDataSource and UITableViewDelegate protocols with profits'
  s.homepage     = 'https://github.com/darrarski/DRTableViewManager-iOS'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.source       = { :git => 'https://github.com/darrarski/DRTableViewManager-iOS', :tag => 'v1.0.1' }
  s.platform     = :ios
  s.source_files = 'DRTableViewManager'
  s.requires_arc = true
end
