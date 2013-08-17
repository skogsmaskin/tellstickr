require 'spec_helper'
describe TellStickR::Device do

  let :device do
    TellStickR::Device.new(12, "Lights", "arctech", "selflearning-switch:nexa")
  end

  it 'initializes' do
    device.id.should eq 12
    device.name.should eq "Lights"
    device.protocol.should eq "arctech"
    device.model.should eq "selflearning-switch:nexa"
  end

  it 'can learn' do
    allow(TellStickR::Core).to receive(:tdLearn).and_return(TellStickR::Core::TELLSTICK_SUCCESS)
    device.learn.should be_true
  end

  it 'can be turned on' do
    allow(TellStickR::Core).to receive(:tdTurnOn).and_return(TellStickR::Core::TELLSTICK_SUCCESS)
    device.on.should be_true
  end

  it 'can be turned off' do
    allow(TellStickR::Core).to receive(:tdTurnOff).and_return(TellStickR::Core::TELLSTICK_SUCCESS)
    device.off.should be_true
  end

  it 'can be belled' do
    allow(TellStickR::Core).to receive(:tdBell).and_return(TellStickR::Core::TELLSTICK_SUCCESS)
    device.bell.should be_true
  end

  it 'can discover devices' do
    allow(TellStickR::Core).to receive(:tdGetNumberOfDevices).and_return(1)
    allow(TellStickR::Core).to receive(:tdGetDeviceId).and_return(12)
    allow(TellStickR::Core).to receive(:tdGetName).and_return("My Device")
    allow(TellStickR::Core).to receive(:tdGetProtocol).and_return("arctech")
    allow(TellStickR::Core).to receive(:tdGetModel).and_return("selflearning-switch:nexa")
    TellStickR::Device.discover.first.name.should eq "My Device"
    TellStickR::Device.discover.first.id.should eq 12
    TellStickR::Device.discover.first.protocol.should eq "arctech"
    TellStickR::Device.discover.first.model.should eq "selflearning-switch:nexa"
  end

  it 'gives human readable exception messages' do
    allow(TellStickR::Core).to receive(:tdBell).and_return(TellStickR::Core::TELLSTICK_ERROR_METHOD_NOT_SUPPORTED)
    lambda { device.bell }.should raise_error TellStickR::Error, "The requested method is not supported by the device (#{TellStickR::Core::TELLSTICK_ERROR_METHOD_NOT_SUPPORTED})"
  end

end
