Pod::Spec.new do |s|
  s.name         = "SGPush"
  s.version      = "0.1"
  s.summary      = "A nice way to handle iOS remote push notifications with just a few code."
  s.description  = <<-DESC
		   SGPush 将处理远程推送时所需的头文件引用、逻辑代码封装到 SGPushHandler 的子类中，当点击远程推送消息打开应用或应用开启状态下接收到远程推送消息时自动执行相应的处理逻辑。
                   DESC

  s.homepage     = "https://github.com/sagiwei/SGPush"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "sagiwei" => "sagiwei@gmail.com" }
  s.social_media_url   = "http://weibo.com/sagiwei"
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/sagiwei/SGPush.git", :tag => 'v0.1' }
  s.source_files  = "SGPush/*.{h,m}"
  s.requires_arc = true
end
