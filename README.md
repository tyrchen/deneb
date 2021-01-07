# Deneb

Deneb is an elixir library to generate [vega-lite](https://vega.github.io/vega-lite/) charts. As an active [Altair](https://github.com/altair-viz/altair) user, I'm pretty jealous of the Python community to have such a great tool to generate beautiful charts. That's why I decided to start to build something similar in Elixir.

So, here comes Deneb...

![Deneb](docs/images/deneb.png)

## Deneb Documentation

See Deneb examples and notebooks, and online documentation.

Note: you need to install [jupyter lab](https://jupyter.org/) and [IElixir](https://github.com/pprzetacznik/IElixir) to run the notebooks.
### 1000-feet glance on Deneb

Here is an example using Deneb to quickly visualize and display a dataset with the native vega-lite renderer in the

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `deneb` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:deneb, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/deneb](https://hexdocs.pm/deneb).
