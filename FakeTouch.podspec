Pod::Spec.new do |s|
  s.name = 'FakeTouch'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'FakeTouch is a framework that simulates iOS touch events.'
  s.homepage = 'https://github.com/watanabetoshinori/FakeTouch'
  s.author = "Watanabe Toshinori"
  s.source = { :git => 'https://github.com/watanabetoshinori/FakeTouch.git', :tag => s.version }
  s.frameworks = 'IOKit'

  s.ios.deployment_target = '12.0'

  s.source_files = 'Source/**/*.{h,m,swift}'

end
