require './graph.rb'
require './stack.rb'



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
    # exact_route(g)
    # depth_first(g, "C")
    find_all_routes(g, "A", "C")
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

def find_all_routes_helper(g, source, destination, visited, path)
    index = g.node_list.find_index(source)
    visited[index] = true
    path << source

    if source === destination
        print path
    else
        source_node = g.find_node(source)

        neighbors = []
            source_node.neighbors.each_with_index do |neighbor, i|
                if neighbor && visited[i] === false
                    neighbors << g.node_list[i]
                    # puts "this is i #{i}"
                    # puts "this is the g node list at i #{g.node_list[i]}"
                    # puts "this is the neighbor #{neighbor}"
                    # find_all_routes_helper(g, g.node_list[i], destination, visited, path)
                    find_all_routes(g, g.node_list[i], destination, visited, path)
                end
            end
    end

    path.pop()
    visited[index]=false
end

def find_all_routes(g, source, destination, visited = [], path =[])
    if visited.length === 0
        visited = [false] * g.node_list.length
    end

    find_all_routes_helper(g, source, destination, visited, path)

end




make_graph()
