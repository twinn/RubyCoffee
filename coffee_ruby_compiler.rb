require "treetop"
Treetop.load("coffee_ruby")

class CoffeeRubyCompiler
  def self.compile(expression)
    parser = CoffeeRubyParser.new
    parse_tree = parser.parse(expression)
    load(parse_tree)
  end

  private

  def self.load(tree)
    tree.elements.each do |class_node|
      load_class(class_node)
    end
  end

  def self.load_class(class_node)
    if class_node.elements[0].text_value == "class "
      klass = Object.const_set(class_node.elements[1].text_value, Class.new)
      class_node.elements[3..-1].each do |method_node|
        load_method(method_node, klass)
      end
    end
  end

  def self.load_method(method_node, klass)
    method_node.elements.each do |other_node|
      method_name = other_node.elements[1].text_value
      klass.class_eval do
        define_method method_name do
          other_node.elements[3..-1].join
        end
      end
    end
  end
end
