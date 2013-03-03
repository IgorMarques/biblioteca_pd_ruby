require_relative '../network/connection_manager'
require_relative '../server/load_balance'

port = 7889
protocol = "TCP"
hostname = "localhost"

load_balance= Load_Balance.new(port, nil, nil, nil)

load_balance.listen(port, protocol)