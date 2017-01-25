defmodule HelloNerves.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :hello_nerves,
     version: "0.2.0",
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
       :nerves_leds,
       :nerves_neopixel,
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
    [{:"nerves_system_#{target}", "~> 0.9"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
