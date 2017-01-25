defmodule HelloNerves do

  def start(_type, _args) do
    #Nerves.Neopixel.start_link([pin: 18, count: 3])
    Nerves.Neopixel.start_link([pin: 18, count: 1])
    spawn fn -> shifty_pixels() end

    led_list = Application.get_env(:blinky, :led_list)
    spawn fn -> blink_list_forever(led_list) end
    {:ok, self}
  end

  defp blink_list_forever(led_list) do
    File.write('/sys/class/leds/led0/brightness','1')
    :timer.sleep 1000
    File.write('/sys/class/leds/led0/brightness','0')
    :timer.sleep 300
    blink_list_forever(led_list)
  end

  defp shifty_pixels() do
    #Nerves.Neopixel.render({127, [{127, 0, 0}, {0, 127, 0}, {0, 0, 127}]})
    Nerves.Neopixel.render({127, [{127, 0, 0}]})
    :timer.sleep 1000
    #Nerves.Neopixel.render({127, [{0, 0, 127}, {127, 0, 0}, {0, 127, 0}]})
    Nerves.Neopixel.render({127, [{0, 127, 0}]})
    :timer.sleep 1000
    #Nerves.Neopixel.render({127, [{0, 127, 0}, {0, 0, 127}, {127, 0, 0}]})
    Nerves.Neopixel.render({127, [{0, 0, 127}]})
    :timer.sleep 1000
    shifty_pixels()
  end

end
