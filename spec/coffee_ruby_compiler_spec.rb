require_relative '../coffee_ruby_compiler'

describe CoffeeRubyCompiler do
  describe '.compile' do
    subject {CoffeeRubyCompiler.compile(expression)}
    let(:expression) do
      File.open("spec/klass.ruby_coffee", "rb").read
    end

    before :all do
      subject
    end

    context 'class definiation' do
      it 'should return the class' do
        Klass.class.should == Class
      end
    end
    context 'method defination' do
      it 'should have a method method' do
        Klass.new.methods.should include :sample_instance_method
      end
      it 'should return true' do
        Klass.new.sample_instance_method.should be_true
      end
    end
  end
end
