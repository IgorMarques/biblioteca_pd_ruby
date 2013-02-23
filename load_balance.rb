# -*- encoding : utf-8 -*-

require_relative 'librarian'
require_relative 'associate'
require_relative 'book'

class Load_Balance

  attr_reader :servers, :server_list, :client_list

  #construtor
  def initialize(online_servers, able_servers, client_list)
    @servers = servers
    @server_list = server_list
    @client_list = client_list
  end

  def facilitade_login()
  end

  def check_server_down()
  end

  def add_new_server()
  end

  def update_able_servers()
  end


end