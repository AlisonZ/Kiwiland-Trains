class Node
    attr_accessor :name, :weights, :neighbors

    def initialize(name)
        @name = name
        @weights = []
        @neighbors = []
    end

end

class Graph
    attr_accessor :nodes, :node_list

    def initialize
        @nodes = []
        @node_list = []
    end

    def add_node(name)
        @nodes << Node.new(name)
        @node_list << name
    end
end
