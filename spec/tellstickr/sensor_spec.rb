require 'spec_helper'

describe TellStickR::Sensor do

  let :sensor do
    TellStickR::Sensor.new("mandolyn", "temperaturehumidity", 1)
  end

  it 'initializes' do
    sensor.protocol.should eq "mandolyn"
    sensor.model.should eq "temperaturehumidity"
    sensor.id.should eq 1
  end

  it 'reads temperature' do
    sensor.temperature.should == {:value=>0.to_f, :time=>Time.at(0)}
  end

  it 'reads humidity' do
    sensor.humidity.should == {:value=>0.to_f, :time=>Time.at(0)}
  end

  it 'can discover sensors' do
    TellStickR::Sensor.discover.class.should eq Array
  end

  it 'has a hash of predefined sensors for easy initialization' do
    TellStickR::Sensor::PREDEFINED_SENSORS.keys.include?(:wt450h).should be_true
  end

  it "can initialize from a predefined sensor product if you know the wireless id, and it's defined in TellStickR::Sensor::PREDEFINED_SENSORS" do
    TellStickR::Sensor.from_predefined(:wt450h, 11).class.should eq TellStickR::Sensor
  end

  it "can not initialize from a predefined sensor product if the product is not defined" do
    lambda { TellStickR::Sensor.from_predefined(:wtf, 9)}.should raise_error
  end

  it 'can register callback functions which are callend when the sensor sends new values' do
    sensor.register_callback(lambda{|data| puts data.inspect}).class.should eq Fixnum
  end

  it 'can unregister a callback function from id' do
    sensor.unregister_callback(1).should be_nil
  end

  it 'can unregister all callbacks' do
    sensor.unregister_callbacks.should == {}
  end

end
