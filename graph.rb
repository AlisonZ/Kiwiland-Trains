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

# TODO: seems these functions should be part of the Graph class
# or working with the app in another way??

def make_graph
    g = Graph.new
    File.open('input.txt', 'r') do |f|
        f.each_line do |line|
            @inputArray = line.split(",").map(&:strip)
        end
    end

    @inputArray.each do |route|
        source = route[0]
        terminal = route[1]
        weight = route[2]

        unless g.nodes.any?{|node| node.name === source}
            g.add_node(source)
        end

    end
    create_edges(g)
end

def create_edges(g)
    g.nodes.each do |node|
        node = node
        name = node.name
        neighbors = [false] * g.node_list.length
        weights = [0] * g.node_list.length

        i = 0
        while i < @inputArray.length do
            terminal = @inputArray[i][1]
            index = g.node_list.find_index(terminal)
            weight = @inputArray[i][2]
            if @inputArray[i][0] === name
                neighbors[index] = true
                weights[index] = weight.to_i
                i+=1
            else
                i+=1
            end
        end

        node.neighbors = neighbors
        node.weights = weights
    end

# TODO: remove from final version
    g.nodes.each do |node|
        puts "this is the neighbors of #{node.name}: #{node.neighbors}"
        puts "this is the weights of #{node.name}: #{node.weights}"
    end
end

make_graph
