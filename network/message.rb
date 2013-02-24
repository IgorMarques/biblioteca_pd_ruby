# -*- encoding : utf-8 -*-

class Message 
  
  attr_reader :host_type, :command, :params  
  attr_accessor :host_type, :command, :params

  def initialize(host_type="", command="", params="")
    @host_type = host_type
    @command = command
    @params = params
  end

  def host_type=(host_type)
    @host_type = host_type
  end

  def command=(command)
    @command = command
  end

  def params=(params)
    @params = params
  end

  def new_param(param)
    @params << param
  end

  def to_string
    result = @host_type.to_s+":"+@command.to_s

    for i in 0..@params.length-1
      result = result + ":" + @params[i].to_s
    end

    return result
  end

  def string_to_message(line)
    l= line.split(":")

    @host_type= l[0];
    @command=l[1];
    @params = l[2..-1]
  end

end