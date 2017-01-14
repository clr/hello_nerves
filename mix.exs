defmodule HelloNerves.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :hello_nerves,
     version: "0.1.0",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.2.1"],
     
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {HelloNerves, []},
     applications: [
       :logger,
       :nerves,
       :nerves_system_rpi3,
       :nerves_system_br,
       :nerves_toolchain_arm_unknown_linux_gnueabihf,
       :nerves_toolchain_ctng,
       :nerves_leds,
       :nerves_neopixel,
       :elixir_make
     ]]
  end

  def deps do
    [
     {:nerves, "~> 0.4.0"},
     {:nerves_leds, "~> 0.7.0"},
     {:nerves_neopixel, "~> 0.3.0"}
    ]
  end

  def system(target) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
