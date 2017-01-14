defmodule HelloNerves do


  def start(_type, _args) do
    exec = "#{:code.priv_dir(:nerves_neopixel)}/rpi_ws281x"
    port = Port.open({:spawn_executable, exec}, [{:args, ["18", "1", "24", "1"]}, {:packet, 2}, :use_stdio, :binary])
    send port, {self, {:command, :erlang.term_to_binary( {0, {254, <<254::size(8), 254::size(8), 254::size(8), 0x00::size(8)>> }} )}}
:timer.sleep 1000
    send port, {self, {:command, :erlang.term_to_binary( {1, {254, <<254::size(8), 254::size(8), 254::size(8), 0x00::size(8)>> }} )}}


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

end
