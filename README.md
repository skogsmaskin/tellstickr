# TellStickR

This is a Gem for communicating with the Telldus TellStick and TellStick Duo through the official telldus-core C library in Ruby.

It also includes device and sensor helper classes for easy communication with various devices and sensors.

If you didn't know, TellSticks are USB radio frequency transmitters which turns any computer into a wireless home automation center (switch on/off electronic devices, read values from sensors, etc).

So far, version 2.1.0 of the telldus-core API is supported.

If you would like to contribute to this code, you are more than welcome to do so!

## Usage

### TellStickR::Core
This is the binding to the telldus-core C library, with all functions and statics defined.
Documentation on these can be found here: http://developer.telldus.se/doxygen/group__core.html

### TellStickR::Device
Class for easy discovery and manipulation of devices.

```
devices = TellStickR::Device.discover
device = devices.first
# Turn it on
device.on
# Turn if off
device.off
# Make it ring (if supported)
device.bell
```

### TellStickR::Sensor
Class for easy discovery and reading sensors.

```
sensors = TellStickR::Sensor.discover
sensor = sensors.first

# Poll temperature
sensor.temperature

# Poll humidity
sensor.humidtity 

# Register a callback that will be called when the sensor receives new data:
callback_id = sensor.register_callback(lambda{|data| puts data.inspect})

# Unregister a spesific callback:
sensor.unregister_callback(callback_id)

# Unregister all callbacks:
sensor.unregister_callbacks

# If you know the make and sensor id, you can do this
# (as long as it's defined in TellStickR::Sensor::PREDEFINED_SENSORS):
sensor = TellStickR::Sensor.from_predefined(:wt450h, 11)
```

## Links

* http://www.telldus.se/products/tellstick
* http://developer.telldus.se/

## Yos and tnx:

- Virus84 for the nice telldus-core on Raspberry Pi guide (https://blogg.itslav.nu/?p=875) which led to this project.
- Hallvar Helleseth for pointing out the Ruby FFI route.
- Kristoffer Sivertsen for introducing me to Tellsticks in the first place :)
- Telldus for a awesome, cheap and trouble-free product!

## Legal
Copyright (c) 2013 Per-Kristian Nordnes. Released under the MIT license. See the file LICENSE.
