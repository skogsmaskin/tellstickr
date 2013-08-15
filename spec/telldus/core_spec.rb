require 'spec_helper'
require 'telldus/core'
describe Telldus::Core do
  it 'fofo' do
    value  = FFI::MemoryPointer.new(:string, 4)
    time  = FFI::MemoryPointer.new(:int, 2)
    Telldus::Core.tdSensorValue("mandolyn", "temperaturehumidity", 11, 1, value, 4, time)
    timestamp = time.get_int32(0)
    degrees = value.get_string(0,4)
    degrees.should eq "foo"
  end
end