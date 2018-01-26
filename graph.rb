class Node
    attr_accessor :name, :weights, :neighbors

    def initialize(name)
        @name = name
        @weights = []
        @neighbors = []
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


# TODO: pull these into another file separate from graph and node classes
# this seems like the actual app that uses the graph and node classes which could be used in other apps
# or working with the app as the way the app starts when program begins

def make_graph
    g = Graph.new
    File.open('input.txt', 'r') do |f|
        f.each_line do |line|
            g.inputArray = line.split(",").map(&:strip)
        end
    end

    g.create_node_list()

    g.inputArray.each do |route|
        name = route[0]
        unless g.nodes.any?{|node| node.name === name}
            g.add_node(name)
            g.create_edges(g, name)
        end
    end

# TODO: remove  print out loop from final version
    # g.nodes.each do |node|
    #     puts "this is the graph node #{node.name}"
    #     puts "this is the neighbors #{node.neighbors}"
    #     puts "this is the weights #{node.weights}"
    # end

start_program(g)
end

def start_program(g)
    # puts "Welcome to Kiwiland Trains Scheduling!"
    # puts "We have several ways to explore your options"
    # puts "Please enter A, B, C... to select which scheduling option you are interested in"
    # puts "A: Exact-Route, B: Number of trips from X-Y with maximum of stops, C: Number of trips from X-Y with exact number of stops, D: Shortest distance from X-Y, or E: Number of different routes from X-Y with a max number of stops"
    # selection = gets.chomp

    # select_route_option(selection)
    exact_route(g)
end

def select_route_option(selection)
    selection.upcase
    if selection === "A"
        exact_route()
    elsif selection === "B"
    # add all of the other selections and have them go to the function for that selection
    else
        puts "that is not a valid selection"
    end
end

def exact_route(g)
    routes = Hash.new
    g.inputArray.each do |route|
        routes[route[0,2]] = route[2]
    end

    puts "Enter the stations list"
    stations = gets.chomp.upcase
    # TODO:
    #this only works for the specific input here with - between routes
    #need to get rid of trailing spaces
    stations = stations.split("-")

    i = 0
    distance = 0
    
    while i < stations.length-1
        route = stations[i]+stations[i+1]
        if routes[route]
            distance += routes[route].to_i
            i+=1
        else
            puts "NO SUCH ROUTE"
            return
        end
    end

    puts distance
end




make_graph
