require 'webrick'
server = WEBrick::HTTPServer.new({
                                     :DocumentRoot => '.',
                                     :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
                                     :Port => '3000',
                                 })
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

#課題のため、追加したページです
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'task.html.erb')
server.mount('/task_indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'task_indicate.rb')
server.mount('/task_goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'task_goya.rb')
server.start