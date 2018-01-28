class Node
    attr_accessor :name, :weights, :neighbors, :visited

    def initialize(name)
        @name = name
        @weights = []
        @neighbors = []
        @visited = false
    end
end

class Graph
    attr_accessor :nodes, :node_list, :inputArray

    def initialize
        @nodes = []
        @node_list = []
        @inputArray = []
    end

    def add_node(name)
        n = Node.new(name)
        @nodes << n
    end

    def create_node_list()
        @inputArray.each do |letter|
            unless @node_list.include?(letter[0])
                @node_list << letter[0]
            end

            unless @node_list.include?(letter[1])
                @node_list << letter[1]
            end
        end
    end


    def find_node(name)
        @nodes.each do |node|
            if node.name === name
                return node
            end
        end
    end

    def create_edges(g, name)
        node = find_node(name)
        neighbors = [false]* @node_list.length
        weights = [0] * @node_list.length

        @inputArray.each do |route|
            source = route[0]
            terminal = route[1]
            weight = route[2]
            index = @node_list.find_index(terminal)


            if source === node.name
                neighbors[index] = true
                weights[index] = weight.to_i
            end

        end

        node.neighbors = neighbors
        node.weights = weights
    end
end
