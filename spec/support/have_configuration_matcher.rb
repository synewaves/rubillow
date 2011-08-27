RSpec::Matchers.define :have_configuration_option do |option|
  match do |configuration|
    configuration.should respond_to(option)

    if instance_variables.include?("@default")
      configuration.send(option).should == @default
    end

    configuration.__send__(:"#{option}=", "value")
    configuration.__send__(option).should == "value"
  end

  chain :default do |default|
    @default = default
  end

  failure_message do
    description  = "expected #{subject} to have"
    description << " configuration option #{option.inspect}"
    description << " with a default of #{@default.inspect}" if instance_variables.include?("@default")
    description
  end
end