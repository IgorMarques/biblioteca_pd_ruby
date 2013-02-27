class Message_Handler
  include Chainable

  def initialize(link = nil, message)
    next_in_chain(link)
    @message = message
  end

end

=begin
 
vc pode usar poliformorfismo nisso ai
ainda mais q eh ruby
ou até mesmo coisas mais absurdas com o send
vc cria o parser
e cria as funcoes
lb_parse
server_parse
client_parse
ai vc faz
MessageParser.send(tipo_de_host + "_parse", mensagem)
magica da programacao dinamica 
=end